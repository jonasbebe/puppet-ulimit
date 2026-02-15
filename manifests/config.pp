################################################################################
# Time-stamp: <Thu 2017-10-05 11:38 svarrette>
#
# File::      <tt>config.pp</tt>
# Author::    Tom De Vylder, Sebastien Varrette
# Copyright:: Copyright (c) 2015-2017 arioch,Falkor
# License::   Apache-2.0
#
# ------------------------------------------------------------------------------
# == Class: ulimit::config
#
# This PRIVATE class handles the configuration of ulimit
#
class ulimit::config {
  File {
    group => $ulimit::config_group,
    owner => $ulimit::config_user,
  }

  file { $ulimit::config_dir:
    ensure  => directory,
    recurse => true,
    purge   => $ulimit::purge,
  }

  if $ulimit::use_default_ulimits {
    $ulimit::default_ulimits.each |$rule_name, $rule_params| {
      ulimit::rule { $rule_name:
        * => $rule_params,
      }
    }
  }

}
