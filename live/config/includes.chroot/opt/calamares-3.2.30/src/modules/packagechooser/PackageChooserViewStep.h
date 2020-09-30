/* === This file is part of Calamares - <https://calamares.io> ===
 *
 *   SPDX-FileCopyrightText: 2019 Adriaan de Groot <groot@kde.org>
 *   SPDX-License-Identifier: GPL-3.0-or-later
 *
 *   Calamares is Free Software: see the License-Identifier above.
 *
 */

#ifndef PACKAGECHOOSERVIEWSTEP_H
#define PACKAGECHOOSERVIEWSTEP_H

#include "DllMacro.h"
#include "locale/TranslatableConfiguration.h"
#include "utils/PluginFactory.h"
#include "viewpages/ViewStep.h"

#include "PackageModel.h"

#include <QObject>
#include <QUrl>
#include <QVariantMap>

class PackageChooserPage;

class PLUGINDLLEXPORT PackageChooserViewStep : public Calamares::ViewStep
{
    Q_OBJECT

public:
    explicit PackageChooserViewStep( QObject* parent = nullptr );
    virtual ~PackageChooserViewStep() override;

    QString prettyName() const override;

    QWidget* widget() override;

    bool isNextEnabled() const override;
    bool isBackEnabled() const override;

    bool isAtBeginning() const override;
    bool isAtEnd() const override;

    void onActivate() override;
    void onLeave() override;

    Calamares::JobList jobs() const override;

    void setConfigurationMap( const QVariantMap& configurationMap ) override;

private:
    void fillModel( const QVariantList& items );
    void hookupModel();

    PackageChooserPage* m_widget;
    PackageListModel* m_model;

    // Configuration
    PackageChooserMode m_mode;
    QString m_id;
    CalamaresUtils::Locale::TranslatedString* m_stepName;  // As it appears in the sidebar
    QModelIndex m_defaultIdx;
};

CALAMARES_PLUGIN_FACTORY_DECLARATION( PackageChooserViewStepFactory )

#endif  // PACKAGECHOOSERVIEWSTEP_H
