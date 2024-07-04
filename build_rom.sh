# sync rom
repo init --depth=1 -u https://github.com/LineageOS/android.git -b lineage-16.0
git clone https://github.com/KAGA-KOKO/local_manifest --depth=1 -b main .repo/local_manifests
repo sync -c -f --no-tags --no-clone-bundle -j8

# build rom
source build/envsetup.sh
lunch lineage_OP4BFB-userdebug
export TZ=Asia/Jakarta #put before last build command
mka bacon

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
