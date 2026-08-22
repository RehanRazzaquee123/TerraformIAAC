resource "azurerm_application_gateway" "network" {
  name                = "appgateway"
  resource_group_name = "rg-tf1"
  location            = "Central India"

  sku {
  name     = "Standard_v2"
  tier     = "Standard_v2"
  capacity = 1
  }
  url_path_map {
  name = "path-routing"

  default_backend_address_pool_name  = "frontend-pool"
  default_backend_http_settings_name = "frontend-settings"

  path_rule {
    name                       = "products-rule"
    paths                      = ["/api/products"]
    backend_address_pool_name  = "product-pool"
    backend_http_settings_name = "product-settings"
  }

  path_rule {
    name                       = "orders-rule"
    paths                      = ["/api/orders"]
    backend_address_pool_name  = "order-pool"
    backend_http_settings_name = "order-settings"
  }

  path_rule {
    name                       = "users-rule"
    paths                      = ["/api/users"]
    backend_address_pool_name  = "user-pool"
    backend_http_settings_name = "user-settings"
  }
}

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = var.subnetid_From_Module["subnet2"]
  }

  frontend_port {
    name = "frontend_port1"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontend_ip_configuration"
    public_ip_address_id = var.pip_From_Module["pip2"]
  }

  backend_address_pool {
  name         = "frontend-pool"
  ip_addresses = [var.nic_private_ip]
}

backend_address_pool {
  name         = "product-pool"
  ip_addresses = [var.nic_private_ip]
}

backend_address_pool {
  name         = "order-pool"
  ip_addresses = [var.nic_private_ip]
}

backend_address_pool {
  name         = "user-pool"
  ip_addresses = [var.nic_private_ip]
}

  backend_http_settings {
  name                  = "frontend-settings"
  port                  = 80
  protocol              = "Http"
  cookie_based_affinity = "Disabled"
  probe_name            = "frontend-probe"
}

backend_http_settings {
  name                  = "product-settings"
  port                  = 8081
  protocol              = "Http"
  cookie_based_affinity = "Disabled"
  probe_name            = "product-probe"
}

backend_http_settings {
  name                  = "order-settings"
  port                  = 8082
  protocol              = "Http"
  cookie_based_affinity = "Disabled"
  probe_name            = "order-probe"
}

backend_http_settings {
  name                  = "user-settings"
  port                  = 8083
  protocol              = "Http"
  cookie_based_affinity = "Disabled"
  probe_name            = "user-probe"
}

  http_listener {
    name                           = "listener_name"
    frontend_ip_configuration_name = "frontend_ip_configuration"
    frontend_port_name             = "frontend_port1"
    protocol                       = "Http"
  }

  request_routing_rule {
  name               = "path-based-routing"
  rule_type          = "PathBasedRouting"
  http_listener_name = "listener_name"
  url_path_map_name  = "path-routing"
  priority            = 9
}
 probe {
    name                = "frontend-probe"
    protocol            = "Http"
    path                = "/"
    interval            = 30
    timeout             = 30
    unhealthy_threshold = 3
    host = "shopflow.example.b18g147.online"
    match {
      status_code = ["200-399"]
    }
  }

  probe {
    name                = "product-probe"
    protocol            = "Http"
    path                = "/api/products"
    interval            = 30
    timeout             = 30
    unhealthy_threshold = 3
    host = "shopflow.example.b18g147.online"
    match {
      status_code = ["200-399"]
    }
  }

  probe {
    name                = "order-probe"
    protocol            = "Http"
    path                = "/api/orders"
    interval            = 30
    timeout             = 30
    unhealthy_threshold = 3
    host = "shopflow.example.b18g147.online"
    match {
      status_code = ["200-399"]
    }
  }

  probe {
    name                = "user-probe"
    protocol            = "Http"
    path                = "/api/users"
    interval            = 30
    timeout             = 30
    unhealthy_threshold = 3
    host = "shopflow.example.b18g147.online"
    match {
      status_code = ["200-399"]
    }
  }
}