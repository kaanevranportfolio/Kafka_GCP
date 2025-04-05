data "template_file" "all_yml" {
  template = file("../ansible_files/group_vars/all.yml.tpl")

  vars = {
    control_server_public_ip = google_compute_instance.control_instance.network_interface.0.access_config.0.nat_ip
    kafka_server_private_ip  = google_compute_instance.kafka_instance.network_interface.0.network_ip
  }
}

data "template_file" "inventory_yml" {
  template = file("../ansible_files/inventory.yml.tpl")

  vars = {
    kafka_server_private_ip = google_compute_instance.kafka_instance.network_interface.0.network_ip
  }
}

resource "local_file" "ansible_all_yml" {

  depends_on = [google_compute_instance.control_instance,
  google_compute_instance.kafka_instance]

  content  = data.template_file.all_yml.rendered
  filename = "../ansible_files/group_vars/all.yml"
}

resource "local_file" "ansible_inventory_yml" {

  depends_on = [google_compute_instance.kafka_instance]

  content  = data.template_file.inventory_yml.rendered
  filename = "../ansible_files/inventory.yml"
}