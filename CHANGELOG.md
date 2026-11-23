# Changelog

## 2026-11-23

### Fixed
- Sonarr was stopped before the download; if the download failed, Sonarr stayed down. All scripts now download and extract first and stop the service just before copying.
- Stable releases are named `Sonarr.main.*`, not `Sonarr.develop.*`, so regular versions never downloaded. The scripts try `main` first, then `develop`.
- If copying fails, the old version is started again.

### Changed
- Work in a temporary folder that is always cleaned up, validate the version number, and check that the service is running afterwards.
- `SONARR_DIR` can override `/usr/lib/sonarr/bin`.
- README: correct clone URL.
