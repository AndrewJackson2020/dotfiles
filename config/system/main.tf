
# Sync system files
resource "local_file" "system_files" {
    for_each = fileset("${path.module}/system", "**")
    content_base64 = filebase64("${path.module}/system/${each.value}")
    filename = "/${each.value}"
}


