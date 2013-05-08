#
# Cookbook Name:: newrelic
# Attributes:: default
#
# Copyright 2011, Myplanet Digital
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# PHP.INI SETTINGS
# at http://support.newrelic.com/kb/php/php-agent-phpini-settings
default[:php][:directives]['newrelic.enabled']                                  = 1
default[:php][:directives]['newrelic.appname']                                  = 'default_app'
default[:php][:directives]['newrelic.transaction_tracer.enable']                = 1
default[:php][:directives]['newrelic.transaction_tracer.threshold']             = 'adpex_f'
default[:php][:directives]['newrelic.transaction_tracer.top100']                = 0
default[:php][:directives]['newrelic.transaction_tracer.record_sql']            = 'obfuscated'
default[:php][:directives]['newrelic.transaction_tracer.stack_trace_theshold']  = 500
default[:php][:directives]['newrelic.transaction_tracer.custom']                = ''
default[:php][:directives]['newrelic.logfile']                                  = ''
default[:php][:directives]['newrelic.loglevel']                                 = 'warning'
default[:php][:directives]['newrelic.enable_params']                            = 0
default[:php][:directives]['newrelic.error_collector.enable']                   = 1
default[:php][:directives]['newrelic.error_collector.record_database_errors']   = 0
default[:php][:directives]['newrelic.webtransaction.name.function']             = ''
default[:php][:directives]['newrelic.webtransaction.name.files']                = ''
default[:php][:directives]['newrelic.webtransaction.name.remove_trailing_path'] = 0
default[:php][:directives]['newrelic.framework']                                = ''
default[:php][:directives]['newrelic.browser_monitoring.auto_instrument']       = 1
default[:php][:directives]['newrelic.timeout']                                  = 10
default[:php][:directives]['newrelic.nonblocking']                              = 1
default[:php][:directives]['newrelic.daemon']                                   = '/tmp/.newrelic.sock'

# NEWRELIC.CFG SETTINGS
# http://support.newrelic.com/kb/php/proxy-daemon-newreliccfg-settings
default[:newrelic][:license_key]             = 'default_license_key'
default[:newrelic][:pidfile]                 = '/var/run/newrelic-daemon.pid'
default[:newrelic][:logfile]                 = '/var/log/newrelic/newrelic-daemon.log'
default[:newrelic][:loglevel]                = 'info'

default[:newrelic][:trace_rpm]                = false
default[:newrelic][:daemon][:collector_host] = 'collector.newrelic.com'
default[:newrelic][:daemon][:ssl]            = false
default[:newrelic][:daemon][:ssl_ca_bundle]  = ''
default[:newrelic][:daemon][:ssl_ca_path]    = ''
default[:newrelic][:daemon][:timeout]        = 30
default[:newrelic][:daemon][:socket]         = '/tmp/.newrelic.sock'
default[:newrelic][:daemon][:max_threads]    = 8
default[:newrelic][:daemon][:metric_limit]   = 2000
default[:newrelic][:daemon][:special]        = 0
default[:newrelic][:daemon][:proxy]          = ''

default[:newrelic][:sm_loglevel]             = 'info'
default[:newrelic][:sm_logfile]              = '/var/log/newrelic/nrsysmond.log'

default[:newrelic][:server][:hostname_prefix] = nil
