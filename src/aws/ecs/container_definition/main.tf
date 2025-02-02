data "aws_region" "current" {}

locals {
  is_not_windows = contains(["LINUX"], var.operating_system_family)

  log_configuration = var.log_configuration

  linux_parameters = var.enable_execute_command ? merge({ "initProcessEnabled" : true }, var.linux_parameters) : merge({ "initProcessEnabled" : false }, var.linux_parameters)

  health_check = length(var.health_check) > 0 ? merge({
    interval = 30,
    retries  = 3,
    timeout  = 5
  }, var.health_check) : null

  definition = {
    command                = length(var.command) > 0 ? var.command : null
    cpu                    = var.cpu
    dependsOn              = length(var.dependencies) > 0 ? var.dependencies : null # depends_on is a reserved word
    disableNetworking      = local.is_not_windows ? var.disable_networking : null
    dnsSearchDomains       = local.is_not_windows && length(var.dns_search_domains) > 0 ? var.dns_search_domains : null
    dnsServers             = local.is_not_windows && length(var.dns_servers) > 0 ? var.dns_servers : null
    dockerLabels           = length(var.docker_labels) > 0 ? var.docker_labels : null
    dockerSecurityOptions  = length(var.docker_security_options) > 0 ? var.docker_security_options : null
    entrypoint             = length(var.entrypoint) > 0 ? var.entrypoint : null
    environment            = var.environment
    environmentFiles       = length(var.environment_files) > 0 ? var.environment_files : null
    essential              = var.essential
    extraHosts             = local.is_not_windows && length(var.extra_hosts) > 0 ? var.extra_hosts : null
    firelensConfiguration  = length(var.firelens_configuration) > 0 ? var.firelens_configuration : null
    healthCheck            = local.health_check
    hostname               = var.hostname
    image                  = var.image
    interactive            = var.interactive
    links                  = local.is_not_windows && length(var.links) > 0 ? var.links : null
    linuxParameters        = local.is_not_windows && length(local.linux_parameters) > 0 ? local.linux_parameters : null
    logConfiguration       = length(local.log_configuration) > 0 ? local.log_configuration : null
    memory                 = var.memory
    memoryReservation      = var.memory_reservation
    mountPoints            = var.mount_points
    name                   = var.name
    portMappings           = var.port_mappings
    privileged             = local.is_not_windows ? var.privileged : null
    pseudoTerminal         = var.pseudo_terminal
    readonlyRootFilesystem = local.is_not_windows ? var.readonly_root_filesystem : null
    repositoryCredentials  = length(var.repository_credentials) > 0 ? var.repository_credentials : null
    resourceRequirements   = length(var.resource_requirements) > 0 ? var.resource_requirements : null
    secrets                = length(var.secrets) > 0 ? var.secrets : null
    startTimeout           = var.start_timeout
    stopTimeout            = var.stop_timeout
    systemControls         = length(var.system_controls) > 0 ? var.system_controls : []
    ulimits                = local.is_not_windows && length(var.ulimits) > 0 ? var.ulimits : null
    user                   = local.is_not_windows ? var.user : null
    volumesFrom            = var.volumes_from
    workingDirectory       = var.working_directory
  }

  # Strip out all null values, ECS API will provide defaults in place of null/empty values
  container_definition = { for k, v in local.definition : k => v if v != null }
}
