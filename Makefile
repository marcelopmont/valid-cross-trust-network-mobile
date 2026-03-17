.PHONY: default setup analyze format clean clean-ios create-package clean-branches

default:
	fvm dart pub get

setup:
	fvm install

analyze:
	fvm dart analyze .

format:
	fvm dart format .

clean:
	@find . -name "pubspec.yaml" -not -path "*/\.*" -exec dirname {} \; | while read dir; do \
		echo "Cleaning $$dir..."; \
		(cd "$$dir" && fvm flutter clean); \
	done

clean-ios: clean
	(cd app && fvm flutter pub get)
	(cd app/ios && rm -f Podfile.lock && (pod deintegrate || true) && pod install --repo-update)

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
