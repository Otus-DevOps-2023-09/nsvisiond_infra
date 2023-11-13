{
    "app": {
        "hosts": ["appserver"]
    },
    "db": {
        "hosts": ["dbserver"]
    },
    "_meta": {
        "hostvars": {
            "appserver": {
                "ansible_host": app_server_ip
            },
            "dbserver": {
                "ansible_host": db_server_ip
            }
        }
    }
}
