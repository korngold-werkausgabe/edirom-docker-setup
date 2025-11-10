# editions-docker-setup

## As Submodule

If the repository is integrated as submodules in a volume repository, the start script must be created once.

```bash
cp editons-docker-setup/template_start-local-docker-setup.sh start-local-docker-setup.sh 
```

Afterwards, the Docker setup can be started and used as follows.

```bash
sh ./start-local-docker-setup.sh
```