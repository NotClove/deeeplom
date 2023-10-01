resource "yandex_kms_symmetric_key" "kms_key" {
  name              = "prod-symetric-key"
  folder_id = "${yandex_resourcemanager_folder.new_folder.id}"
  description       = "symetric key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h"
}
