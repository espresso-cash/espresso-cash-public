include ../../Makefile

deploy_server:
	gcloud run deploy backend --region=europe-west1 --source . --project cryptoplease-dev

deploy_firebase:
	firebase deploy --only hosting
