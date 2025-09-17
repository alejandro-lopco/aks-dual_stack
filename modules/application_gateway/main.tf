module "rn" {
  source = "../resource_naming"
}
module "vNet" {
  source = "../virtual_network"

  vnet_name           = "${var.vnet_name}${module.rn.prefix}"
  resource_group_name = var.resource_group_name

  subscription_id     = var.subscription_id
  location            = var.location

  address_space     = var.address_space
  address_prefixes  = var.address_prefixes
}
module "public_ip" {
  source = "../public_ip"

  public_ip_name    = var.public_ip_name
  domain_name_label = var.domain_name_label

  resource_group_name = var.resource_group_name

  subscription_id     = var.subscription_id
  location            = var.location
}

resource "azurerm_application_gateway" "this" {
  name                = "agw-${var.gateway_name}-${module.rn.prefix}"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = var.sku.name
    tier     = var.sku.tier
    capacity = var.sku.capacity
  }

  enable_http2 = var.enable_http2

  zones = var.zones

  gateway_ip_configuration {
    name      = "${var.gateway_name}-ip-config"
    subnet_id = module.vNet.subvNet_id
  }

  dynamic "frontend_port" {
    for_each = var.listener

    content {
      name = "${frontend_port.value.name}-feport"
      port = frontend_port.value.frontend_port
    }
  }

  dynamic "frontend_ip_configuration" {
    for_each = var.listener

    content {
      name                 = "${frontend_ip_configuration.value.name}-feip"
      public_ip_address_id = module.public_ip.id
    }
  }

  dynamic "http_listener" {
    for_each = var.listener

    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = "${http_listener.value.name}-feip"
      frontend_port_name             = "${http_listener.value.name}-feport"
      protocol                       = try(http_listener.value.protocol, null)
      ssl_certificate_name           = try(http_listener.value.ssl_certificate_name, null)
      ssl_profile_name               = try(http_listener.value.ssl_profile_name, null)
    }
  }

  dynamic "backend_address_pool" {
    for_each = var.backend_address_pool

    content {
      name         = backend_address_pool.value.name
      fqdns        = backend_address_pool.value.fqdns
      ip_addresses = backend_address_pool.value.ip_addresses
    }
  }

  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings
    content {
      name                  = backend_http_settings.value.name
      cookie_based_affinity = backend_http_settings.value.cookie_based_affinity
      port                  = backend_http_settings.value.port
      protocol              = backend_http_settings.value.protocol
      request_timeout       = backend_http_settings.value.request_timeout
      host_name             = backend_http_settings.value.host_name
      probe_name            = backend_http_settings.value.probe_name
    }
  }

  dynamic "request_routing_rule" {
    for_each = var.request_routing_rule
    content {
      name               = request_routing_rule.value.name
      priority           = request_routing_rule.value.priority
      rule_type          = request_routing_rule.value.rule_type
      http_listener_name = request_routing_rule.value.http_listener_name
      url_path_map_name  = request_routing_rule.value.url_path_map_name
    }
  }

  dynamic "url_path_map" {
    for_each = var.url_path_map
    content {
      name                               = url_path_map.value.name
      default_backend_address_pool_name  = url_path_map.value.default_backend_address_pool_name
      default_backend_http_settings_name = url_path_map.value.default_backend_http_settings_name

      dynamic "path_rule" {
        for_each = url_path_map.value.path_rules
        content {
          name                       = path_rule.value.name
          paths                      = path_rule.value.paths
          backend_address_pool_name  = path_rule.value.backend_address_pool_name
          backend_http_settings_name = path_rule.value.backend_http_settings_name
          rewrite_rule_set_name      = path_rule.value.rewrite_rule_set_name
        }
      }
    }
  }

  dynamic "rewrite_rule_set" {
    for_each = var.rewrite_rule_set
    content {
      name = rewrite_rule_set.value.name

      dynamic "rewrite_rule" {
        for_each = rewrite_rule_set.value.rewrite_rule
        content {
          name          = rewrite_rule.value.name
          rule_sequence = rewrite_rule.value.rule_sequence

          url {
            path         = rewrite_rule.value.url.path
            query_string = rewrite_rule.value.url.query_string
          }
        }
      }
    }
  }

  dynamic "autoscale_configuration" {
    for_each = var.autoscale_configuration == null ? [] : [null]
    content {
      min_capacity = var.autoscale_configuration.min_capacity
      max_capacity = var.autoscale_configuration.max_capacity
    }
  }

  dynamic "probe" {
    for_each = var.probe
    content {
      name                = probe.value.name
      path                = probe.value.path
      interval            = probe.value.interval
      timeout             = probe.value.timeout
      unhealthy_threshold = probe.value.unhealthy_threshold
      protocol            = probe.value.protocol
      host                = probe.value.host

      dynamic "match" {
        for_each = probe.value.match == null ? [] : [null]
        content {
          status_code = probe.value.match.status_code
        }
      }
    }
  }

  dynamic "ssl_certificate" {
    for_each = var.ssl_certificate
    content {
      name                = ssl_certificate.value.name
      key_vault_secret_id = ssl_certificate.value.key_vault_secret_id
    }
  }

  dynamic "ssl_profile" {
    for_each = var.ssl_profile
    content {
      name                                 = ssl_profile.value.name
      trusted_client_certificate_names     = ssl_profile.value.trusted_client_certificate_names
      verify_client_cert_issuer_dn         = ssl_profile.value.verify_client_cert_issuer_dn
      verify_client_certificate_revocation = ssl_profile.value.verify_client_certificate_revocation

      ssl_policy {
        cipher_suites        = ssl_profile.value.ssl_policy.cipher_suites
        disabled_protocols   = ssl_profile.value.ssl_policy.disabled_protocols
        min_protocol_version = ssl_profile.value.ssl_policy.min_protocol_version
        policy_name          = ssl_profile.value.ssl_policy.policy_name
        policy_type          = ssl_profile.value.ssl_policy.policy_type
      }
    }
  }

  tags = merge(var.tags, { service = "application gateway", type = "Networking", vNet = "${module.vNet.name}" })
}
