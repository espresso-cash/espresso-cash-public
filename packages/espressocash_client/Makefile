include ../../Makefile

gen_proto:
	protoc --dart_out=grpc:lib/src/generated -Iprotos/ -Ithird_party/ $$(find protos -name "*.proto")

