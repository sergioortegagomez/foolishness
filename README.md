# foolishness

## How to run this project?

Start the platform:

```console
$ bin/platformcontrol.sh up
```

And enter to your dev virtual machine

```console
$ bin/platformcontrol.sh ssh
```

Move to workspace by default

```console
$ cd /vagrant
```

### Build your project

```console
$ bin/devcontrol.sh build
```

### Up up up! :)

```console
$ bin/devcontrol.sh start
```

## Gatling test

```console
$ docker-compose -f docker-compose.gatling.yml up
```