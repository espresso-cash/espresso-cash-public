FROM dart:stable AS build

WORKDIR /app

# Copy app source code and AOT compile it.
COPY . .
RUN dart pub get
RUN dart compile exe bin/server.dart -o bin/server

# Build minimal serving image from AOT-compiled `/server` and required system
# libraries and configuration files stored in `/runtime/` from the build stage.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/bin/

# Include files in the /public directory to enable static asset handling
COPY --from=build /app/public/ /public
COPY --from=build /app/templates/ /templates

# Start server.
EXPOSE 8080
CMD ["/app/bin/server"]
