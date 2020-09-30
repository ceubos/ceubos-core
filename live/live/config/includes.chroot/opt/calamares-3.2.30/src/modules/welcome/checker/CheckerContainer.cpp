/* === This file is part of Calamares - <https://calamares.io> ===
 *
 *   SPDX-FileCopyrightText: 2014-2017 Teo Mrnjavac <teo@kde.org>
 *   SPDX-FileCopyrightText: 2017 Adriaan de Groot <groot@kde.org>
 *   SPDX-FileCopyrightText: 2017 Gabriel Craciunescu <crazy@frugalware.org>
 *   SPDX-License-Identifier: GPL-3.0-or-later
 *
 *   Calamares is Free Software: see the License-Identifier above.
 *
 */

/* Based on code extracted from RequirementsChecker.cpp */

#include "CheckerContainer.h"

#include "ResultsListWidget.h"

#include "utils/CalamaresUtilsGui.h"
#include "utils/Logger.h"
#include "utils/Retranslator.h"
#include "widgets/WaitingWidget.h"

#include <QHBoxLayout>

CheckerContainer::CheckerContainer( const Calamares::RequirementsModel& model, QWidget* parent )
    : QWidget( parent )
    , m_waitingWidget( new WaitingWidget( QString(), this ) )
    , m_checkerWidget( nullptr )
    , m_verdict( false )
    , m_model( model )
{
    QBoxLayout* mainLayout = new QHBoxLayout;
    setLayout( mainLayout );
    CalamaresUtils::unmarginLayout( mainLayout );

    mainLayout->addWidget( m_waitingWidget );
    CALAMARES_RETRANSLATE( if ( m_waitingWidget ) m_waitingWidget->setText( tr( "Gathering system information..." ) ); )
}

CheckerContainer::~CheckerContainer()
{
    delete m_waitingWidget;
    delete m_checkerWidget;
}

void
CheckerContainer::requirementsComplete( bool ok )
{
    if ( !ok )
    {
        cDebug() << "Requirements not satisfied" << m_model.count() << "entries:";
        for ( int i = 0; i < m_model.count(); ++i )
        {
            auto index = m_model.index( i );
            cDebug() << Logger::SubEntry << i << m_model.data( index, Calamares::RequirementsModel::Name ).toString()
                     << "set?" << m_model.data( index, Calamares::RequirementsModel::Satisfied ).toBool() << "req?"
                     << m_model.data( index, Calamares::RequirementsModel::Mandatory ).toBool();
        }
    }

    layout()->removeWidget( m_waitingWidget );
    m_waitingWidget->deleteLater();
    m_waitingWidget = nullptr;  // Don't delete in destructor

    m_checkerWidget = new ResultsListWidget( m_model, this );
    layout()->addWidget( m_checkerWidget );

    m_verdict = ok;
}

void
CheckerContainer::requirementsProgress( const QString& message )
{
    if ( m_waitingWidget )
    {
        m_waitingWidget->setText( message );
    }
}

bool
CheckerContainer::verdict() const
{
    return m_verdict;
}
