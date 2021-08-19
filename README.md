# Theme for Publik interne by "Département de Loire Atlantique"

## License
This project is licensed under the terms of the MIT license.

## Install
```
git clone https://github.com/departement-loire-atlantique/publik-themes-interne --recurse-submodules
cd publik-themes-interne
make install
```

## After each change
```
make clean && make install
```

## How to update the publik-base-theme submodule

Get the version from the tag name of the last released version.

Example :
https://git.entrouvert.org/publik-base-theme.git/tag/?id=v6.94

The version is : 2c5427f50f515849311c7f4f621255b3f8fb421f

````
git -C .\publik-base-theme\ checkout 2c5427f50f515849311c7f4f621255b3f8fb421f 
git add .\publik-base-theme\
git commit -m "update publik-base-theme submodule to new version"
git push
````

## How themes work
We're following [Entr'ouvert guidelines](https://dev.entrouvert.org/projects/prod-eo/wiki/HowDoWeDoThemes).

