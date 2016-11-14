## KMSTool

Cli tool to encrypt/decrypt strings around regexp with aws kms.

```text
# help
$ kmstool
$ kmstool help

# encode, outputs base64 string
$ kmstool --region eu-central-1 --cmk 6fefef0f-5338-47ed-b6e7-aadccadadc0c encrypt kms:topsecretpassword
> AQECAHjJBAV5TqmKpyCsInhMgivwp3V6gwYG3+P6TeV7ZAV6BgAAAGIwYAYJKoZIhvcNAQcGoFMwUQIBADBMBgkqh...

# decode, outputs decoded plaintext
$ kmstool --region eu-central-1 decrypt kms:AQECAHjJBAV5TqmKpyCsInhMgivwp3V6gwYG3+P6TeV7ZAV6BgAAAGIwYAYJKoZIhvcNAQcG...
> kms:topsecretpassword

```

### Workflow

Put your generated password into a structured file. For example: `secrets.yaml`
```yaml
parameters:
	myql_password: kms:r00tP4ssw0rd
	google_secret: kms:s3cr4t$$
```

Use kmstool to encrypt the passwords and output the full file with encrypted results
```text
# encode, outputs base64 string
$ kmstool --region eu-central-1 --cmk 6fefef0f-5338-47ed-b6e7-aadccadadc0c encrypt < secrets.yaml
>parameters:
>	myql_password: AQECAHjJBAV5TqmKpyCsInhMgivwp3V6gwYG...
>	google_secret: givwp3V6gwYG3+P6TeV7ZAV6BgAAAGIwYAYJ...

```

Store it. You can use output redirection to put it to a file automatically, 
```text
$ kmstool --region eu-central-1 --cmk 6fefef0f-5338-47ed-b6e7-aadccadadc0c encrypt < secrets.yaml > encripedsecrets.yaml

```

Whenever needed, decrypt it and put the plain passwords back so your app can read them out
```text
# decode, outputs decoded plaintext
$ kmstool --region eu-central-1 decrypt < secrets.yaml
>parameters:
>	myql_password: r00tP4ssw0rd
>	google_secret: s3cr4t$$
```

Use output redirection and store it.

### How to configure

It uses your aws settings from `~/.aws/config` by default.

You can also use the following env variables to set up aws auth:
`AWS_ACCESS_KEY_ID, AWS_SECRET_KEY, AWS_SESSION_TOKEN`

Before running encrypt / decrypt it parses the input text using regexp (_can be specified using `--regexp`_), then
runs the command on it and replaces it back to the original text.
Command basically calls aws golang sdk with and that is it.

Yes, that simple.

### Why?

We needed a cli tool that just works without installing anything else and does not need binary file input to decode, like aws cli.

## For Devs

* Please use go1.7+
* Clone repository into yourProjectDirectory/src/github.com/foodpanda/kmstool
* Set your GOPATH to yourProjectDirectory
* Set PATH to yourProjectDirectory/bin
* Run `make`
* Do your stuff
* Run `make test`
* Run `make fmt`




The MIT License (MIT)
Copyright (c) 2016 Foodpanda GmbH, https://foodpanda.io

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
