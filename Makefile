.PHONY: default setup analyze format clean clean-ios create-package clean-branches

default:
	melos bs

setup:
	fvm install
	fvm dart pub global activate melos

analyze:
	melos run analyze:flutter --no-select

format:
	melos run format --no-select

clean:
	melos clean
	melos bs

clean-ios:
	melos clean
	melos bs
	(cd root_app && fvm flutter clean && fvm flutter pub get)
	(cd root_app/ios && rm -f Podfile.lock && (pod deintegrate || true) && pod install --repo-update)

create-package:
	chmod +x scripts/create-flutter-package.sh
	@scripts/create-flutter-package.sh $(name) $(path)

clean-branches:
	@git fetch --prune
	@git branch -vv | grep ': gone]' | awk '{print $$1}' | while read branch; do \
		if [ "$$branch" != "main" ] && [ "$$branch" != "master" ]; then \
			echo "Deleting branch: $$branch"; \
			git branch -D "$$branch"; \
		fi \
	done
