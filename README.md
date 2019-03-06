# Selenium in Kubernetes (or OpenShift)

This project is based from the awesome repository of 
[Kubernetes Samples](https://github.com/kubernetes/examples/tree/master/staging/selenium).

Tested in the following.

```
minishift v1.30.0+186b034
oc v3.11.0+0cbc58b
kubernetes v1.11.0+d4cacc0
```

## Requirements

To properly run `make` ensure you have `j2cli`. See 
[kolypto/j2cli](https://github.com/kolypto/j2cli) for more
details.

## Configuration

Inspect `resources/creds` and `resources/cfg.json` and set 
the values appropriately to match your requirements.

```
OCPNAM := selenium
OCPURL := https://192.168.99.104:8443
OCPTKN := 0oFGFhhkEIwVV_AySLdF20Y_UUmLvDRh1bnE-3R5oPI
```

```json
{
  "selenium": {
    "hub": {
      "replicas": "1",
      "image": "selenium/hub:3.141",
      "service": {
        "host": "selenium.192.168.99.104.nip.io"
      }
    },
    "node": {
      "chrome": {
        "replicas": "1",
        "image": "selenium/node-chrome-debug:3.141.59-iron"
      },
      "firefox": {
        "replicas": "1",
        "image": "selenium/node-firefox-debug:3.141.59-iron"
      }
    }
  }
}
```

## Usage

Run `make help` to list targets.

## Debugging

Get the pod name then port-forward 'em like so...

```
kubectl port-forward selenium-node-chrome-5b64f55fc5-dqdwv 5900:5900
```

Then use VNC Viewer and connect to `localhost:5900`