
# Sync system files
resource "local_file" "system_files" {
    for_each = fileset("${path.module}/home", "**")
    content = file("${path.module}/home/${each.value}")
    filename = "/home/andrew/${each.value}"
}
