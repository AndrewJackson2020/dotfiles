

# Sync system files
resource "local_file" "system_files" {
    for_each = fileset("${path.module}/system", "**")
    content = filebase64("${path.module}/system/${each.value}")
    filename = "/${each.value}"
}


# Sync home files
resource "local_file" "home_files" {
    for_each = fileset("${path.module}/home", "**")
    content = filebase64("${path.module}/home/${each.value}")
    filename = "/home/andrew/{$each.value}"
}

