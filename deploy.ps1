yarn build

cd dist

git init
git add -A
git commit -m 'deploy'

git push -f https://github.com/Spartan0nix/js-regex-debugger.git dev:gh-pages