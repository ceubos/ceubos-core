/* === This file is part of Calamares - <https://calamares.io> ===
 *
 *   SPDX-FileCopyrightText: 2020 Adriaan de Groot <groot@kde.org>
 *   SPDX-License-Identifier: GPL-3.0-or-later
 *
 *   Calamares is Free Software: see the License-Identifier above.
 *
 */

#include "Config.h"

#include "JobQueue.h"
#include "utils/Logger.h"
#include "utils/Yaml.h"

#include <QtTest/QtTest>

// Implementation details
extern void setConfigurationDefaultGroups( const QVariantMap& map, QStringList& defaultGroups );
extern HostNameActions getHostNameActions( const QVariantMap& configurationMap );
extern bool addPasswordCheck( const QString& key, const QVariant& value, PasswordCheckList& passwordChecks );

/** @brief Test Config object methods and internals
 *
 */
class UserTests : public QObject
{
    Q_OBJECT
public:
    UserTests();
    virtual ~UserTests() {}

private Q_SLOTS:
    void initTestCase();

    void testDefaultGroups();
    void testDefaultGroupsYAML_data();
    void testDefaultGroupsYAML();

    void testHostActions_data();
    void testHostActions();
    void testPasswordChecks();
    void testUserPassword();
};

UserTests::UserTests() {}

void
UserTests::initTestCase()
{
    Logger::setupLogLevel( Logger::LOGDEBUG );
    cDebug() << "Users test started.";
}

void
UserTests::testDefaultGroups()
{
    {
        QStringList groups;
        QVariantMap hweelGroup;
        QVERIFY( groups.isEmpty() );
        hweelGroup.insert( "defaultGroups", QStringList { "hweel" } );
        setConfigurationDefaultGroups( hweelGroup, groups );
        QCOMPARE( groups.count(), 1 );
        QVERIFY( groups.contains( "hweel" ) );
    }

    {
        QStringList desired { "wheel", "root", "operator" };
        QStringList groups;
        QVariantMap threeGroup;
        QVERIFY( groups.isEmpty() );
        threeGroup.insert( "defaultGroups", desired );
        setConfigurationDefaultGroups( threeGroup, groups );
        QCOMPARE( groups.count(), 3 );
        QVERIFY( !groups.contains( "hweel" ) );
        QCOMPARE( groups, desired );
    }

    {
        QStringList groups;
        QVariantMap explicitEmpty;
        QVERIFY( groups.isEmpty() );
        explicitEmpty.insert( "defaultGroups", QStringList() );
        setConfigurationDefaultGroups( explicitEmpty, groups );
        QCOMPARE( groups.count(), 0 );
    }

    {
        QStringList groups;
        QVariantMap missing;
        QVERIFY( groups.isEmpty() );
        setConfigurationDefaultGroups( missing, groups );
        QCOMPARE( groups.count(), 6 );  // because of fallback!
        QVERIFY( groups.contains( "lp" ) );
    }

    {
        QStringList groups;
        QVariantMap typeMismatch;
        QVERIFY( groups.isEmpty() );
        typeMismatch.insert( "defaultGroups", 1 );
        setConfigurationDefaultGroups( typeMismatch, groups );
        QCOMPARE( groups.count(), 6 );  // because of fallback!
        QVERIFY( groups.contains( "lp" ) );
    }
}

void
UserTests::testDefaultGroupsYAML_data()
{
    QTest::addColumn< QString >( "filename" );
    QTest::addColumn< int >( "count" );
    QTest::addColumn< QString >( "group" );

    QTest::newRow( "users.conf" ) << "users.conf" << 7 << "video";
    QTest::newRow( "dashed list" ) << "tests/4-audio.conf" << 4 << "audio";
    QTest::newRow( "blocked list" ) << "tests/3-wing.conf" << 3 << "wing";
}

void
UserTests::testDefaultGroupsYAML()
{
    if ( !Calamares::JobQueue::instance() )
    {
        (void)new Calamares::JobQueue();
    }

    QFETCH( QString, filename );
    QFETCH( int, count );
    QFETCH( QString, group );

    QFile fi( QString( "%1/%2" ).arg( BUILD_AS_TEST, filename ) );
    QVERIFY( fi.exists() );

    bool ok = false;
    const auto map = CalamaresUtils::loadYaml( fi, &ok );
    QVERIFY( ok );
    QVERIFY( map.count() > 0 );

    Config c;
    c.setConfigurationMap( map );

    QCOMPARE( c.defaultGroups().count(), count );
    QVERIFY( c.defaultGroups().contains( group ) );
}


void
UserTests::testHostActions_data()
{
    QTest::addColumn< bool >( "set" );
    QTest::addColumn< QString >( "string" );
    QTest::addColumn< int >( "result" );

    QTest::newRow( "unset  " ) << false << QString() << int( HostNameAction::EtcHostname );
    QTest::newRow( "empty  " ) << true << QString() << int( HostNameAction::EtcHostname );
    QTest::newRow( "bad    " ) << true << QString( "derp" ) << int( HostNameAction::EtcHostname );
    QTest::newRow( "none   " ) << true << QString( "none" ) << int( HostNameAction::None );
    QTest::newRow( "systemd" ) << true << QString( "Hostnamed" ) << int( HostNameAction::SystemdHostname );
}

void
UserTests::testHostActions()
{
    QFETCH( bool, set );
    QFETCH( QString, string );
    QFETCH( int, result );

    QVariantMap m;
    if ( set )
    {
        m.insert( "setHostname", string );
    }
    QCOMPARE( getHostNameActions( m ),
              HostNameActions( result ) | HostNameAction::WriteEtcHosts );  // write bits default to true
    m.insert( "writeHostsFile", false );
    QCOMPARE( getHostNameActions( m ), HostNameActions( result ) );
    m.insert( "writeHostsFile", true );
    QCOMPARE( getHostNameActions( m ), HostNameActions( result ) | HostNameAction::WriteEtcHosts );
}

void
UserTests::testPasswordChecks()
{
    {
        PasswordCheckList l;
        QCOMPARE( l.length(), 0 );
        QVERIFY( !addPasswordCheck( "nonempty", QVariant( false ), l ) );  // a silly setting
        QCOMPARE( l.length(), 0 );
        QVERIFY( addPasswordCheck( "nonempty", QVariant( true ), l ) );
        QCOMPARE( l.length(), 1 );
    }
}

void
UserTests::testUserPassword()
{
    if ( !Calamares::JobQueue::instance() )
    {
        (void)new Calamares::JobQueue( nullptr );
    }

    {
        Config c;

        QVERIFY( c.userPassword().isEmpty() );
        QVERIFY( c.userPasswordSecondary().isEmpty() );
        // There are no validity checks, so no check for nonempty
        QCOMPARE( c.userPasswordValidity(), Config::PasswordValidity::Valid );

        c.setUserPassword( "bogus" );
        QCOMPARE( c.userPasswordValidity(), Config::PasswordValidity::Invalid );
        QCOMPARE( c.userPassword(), "bogus" );
        c.setUserPasswordSecondary( "bogus" );
        QCOMPARE( c.userPasswordValidity(), Config::PasswordValidity::Valid );
    }

    {
        Config c;

        QVariantMap m;
        m.insert( "allowWeakPasswords", true );
        m.insert( "allowWeakPasswordsDefault", true );
        m.insert( "defaultGroups", QStringList { "wheel" } );

        QVariantMap pwreq;
        pwreq.insert( "nonempty", true );
        pwreq.insert( "minLength", 6 );
        m.insert( "passwordRequirements", pwreq );

        c.setConfigurationMap( m );

        QVERIFY( c.userPassword().isEmpty() );
        QVERIFY( c.userPasswordSecondary().isEmpty() );
        // There is now a nonempty check, but weak passwords are ok
        QCOMPARE( c.userPasswordValidity(), int( Config::PasswordValidity::Weak ) );

        c.setUserPassword( "bogus" );
        QCOMPARE( c.userPasswordValidity(), int( Config::PasswordValidity::Invalid ) );
        c.setUserPasswordSecondary( "bogus" );
        QCOMPARE( c.userPasswordValidity(), int( Config::PasswordValidity::Weak ) );

        QVERIFY( !c.requireStrongPasswords() );
        c.setRequireStrongPasswords( true );
        QVERIFY( c.requireStrongPasswords() );
        // Now changed requirements make the password invalid
        QCOMPARE( c.userPassword(), "bogus" );
        QCOMPARE( c.userPasswordValidity(), int( Config::PasswordValidity::Invalid ) );
    }

    {
        Config c;
        QVERIFY( c.userPassword().isEmpty() );
        QCOMPARE( c.userPasswordValidity(), Config::PasswordValidity::Valid );

        QSignalSpy spy_pwChanged( &c, &Config::userPasswordChanged );
        QSignalSpy spy_pwSecondaryChanged( &c, &Config::userPasswordSecondaryChanged );
        QSignalSpy spy_pwStatusChanged( &c, &Config::userPasswordStatusChanged );

        c.setUserPassword( "bogus" );
        c.setUserPassword( "bogus" );
        QCOMPARE( spy_pwChanged.count(), 1 );
        QCOMPARE( spy_pwStatusChanged.count(), 1 );
        QCOMPARE( c.userPasswordValidity(), Config::PasswordValidity::Invalid );
        c.setUserPassword( "sugob" );
        c.setUserPasswordSecondary( "sugob" );
        QCOMPARE( spy_pwChanged.count(), 2 );
        QCOMPARE( spy_pwSecondaryChanged.count(), 1 );
        QCOMPARE( spy_pwStatusChanged.count(), 3 );
        QCOMPARE( c.userPasswordValidity(), Config::PasswordValidity::Valid );
    }
}


QTEST_GUILESS_MAIN( UserTests )

#include "utils/moc-warnings.h"

#include "Tests.moc"
