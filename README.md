# Panoramic image stitching

Panoramic image stitching in matlab

## Dependencies

* vlfeat-0.9.20
  * Make sure the vlfeat-0.9.20 package is located under the root directory
  * If the packaged isn't there, download it from [here](http://www.vlfeat.org/download/vlfeat-0.9.20-bin.tar.gz)

## Directory structure

```
.
├─ README.md
├─ doc (report and other documents)
│   └── ...
├─ data (source images)
│   └── ...
├─ result (the results)
│   └── final.jpg (the panorama)
├─ vlfeat-0.9.20 (the vlfeat binary package)
│   └── ... 
└─ src (the matlab source code)
    └── ...
```

## How to run it

1. Make sure you have the vlfeat-0.9.20 package under the root directory
2. Place the source images under the `data` folder
  * Currenly it only handles jpg
  * Make sure the images are in portrait mode
3. Open the `src` folder in matlab
4. Open main.m and run
  * This project is specifically configured for NIKON E990, if you need to stitch images taken from other cameras, you need to configure `f`, `k1` and `k2` in main.m
  * The method for calculating/obtaining `f`, `k1` and `k2` for a camera is commented in main.m

## Reference
[M. Brown and D. Lowe, "Recognising Panoramas", ICCV 2003.](https://www.cs.bath.ac.uk/brown/papers/iccv2003.pdf)

## About
* Author: Joyee Chueng
* Email: [joyeec9h3@gmail.com](mailto:joyeec9h3@gmail.com)
* Github Repo: [joyeecheung/panoramic-image-stitching](https://github.com/joyeecheung/panoramic-image-stitching)