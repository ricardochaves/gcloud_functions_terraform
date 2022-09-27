# GCloud terraform function

Create a new Google Cloud project

Create a new service account to use in terraform, localhost and in terraform cloud.
- Secret Manager Admin
- Storage Admin
- Security Admin
- Service Account Admin
- Pub/Sub Editor
- Cloud Schedule Admin
- Cloud Functions Admin

Generate a new key with json format

Move the key to the root of the project

`gcloud auth activate-service-account terraform@production-363623.iam.gserviceaccount.com --key-file=production-363623-0810979e1116.json --project=production-363623`

APIs to enable
- Secret Manager API
- Cloud Pub/Sub API
- Identity and Access Management (IAM) API
- Cloud Resource Manager API
- Cloud Functions API
- Cloud Scheduler API
- Cloud Build API


Update `credentials` in `main.tf`

Update `variables.tf`
