# Datu ingenieritza

Repositorio honek datu-ingeniaritzarekin lotutako fitxategiak ditu, hala nola, azpiegitura-konfigurazioak, automatizazio-scriptak eta konfigurazio-fitxategiak. Jarraian fitxategien egituraren eta bere edukiaren ikuspegi orokorra egiten da.

## Fitxategiak

- **ansible/**: Ansible erabiliz azpiegitura konfiguratu eta automatizatzearekin lotutako fitxategiak eta fitxategiak ditu.
  - **ansible.cfg**: Ansible fitxategi konfigurazioa.
  - **group_vars**: Ansiblerako aldagai globalak.
  - **inventory**: Makinen helbideak gordetzeko.
  - **playbooks**: Zereginen zerrenda.
  - **roles**: Zeregin bakoitzerako beharrezko fitxategi eta pausuak.

- **install**: Beharrezko tresnetarako eta dependentzien instalazio-scriptak ditu.
  - **install-ansible.sh**: Ansible instalatzeko script-a.
  - **install-gcloud.sh**: Google Cloud SDK instalatzeko script-a.
  - **install-opentofu.sh**: OpenTofu instalatzeko script-a.

- **opentofu/**: Azpiegiturarako konfigurazioarekin lotutako fitxategiak.
  - **gcp/**: Google Cloud Platform (GCP)  VM en konfigurazioak.
  - **proxmox/**: Proxmoxeko LXC ren konfigurazioak.

- **PBL6.json**: Proiektuaren konfigurazio batekin erlazionatutako JSON fitxategia.
