# hydra-consent-app-express

This is an exemplary consent application that implements ORY Hydra's consent flow. It uses NodeJS and express.

A consent application is responsible for:

* Authenticating users (signing a user in)
* Authorizing an application ("Would you like to give application X access to your email address?")

You can use this demo for a rough guide on how to implement the consent flow using NodeJS. The only important source file is [this](https://github.com/ory/hydra-consent-app-express/blob/master/routes/index.js), everything else was created using `express init .`.

## docker

To run this application using docker

```console
$ docker run --name hydra-consent-app-express \
            -p 3000:8080 \
            -e HYDRA_URL="http://localhost:4444"" \
            -e HYDRA_CLIENT_ID="demo>" \
            -e HYDRA_CLIENT_SECRET="demo" \
            boeboe/hydra-consent-app-express
```


This demo consent application contains only one user

```javascript
const user = {
  email: 'demo@aspenmesh.io',
  password: 'secret',

  email_verified: true,
  user_id: 'user:12345:aspenmesh',
  name: 'Aspen Mesh',
  nickname: 'Aspen',
}
```