# Build system colors
  CL_RED="\033[31m"
  CL_GRN="\033[32m"
  CL_YLW="\033[33m"
  CL_BLU="\033[34m"
  CL_MAG="\033[35m"
  CL_CYN="\033[36m"
  CL_RST="\033[0m"

HASH_TARGET_PACKAGE := $(PRODUCT_OUT)/HashOS-$(HASH_VERSION).zip

.PHONY: otapackage banana bacon
otapackage: $(INTERNAL_OTA_PACKAGE_TARGET)
banana: otapackage
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(HASH_TARGET_PACKAGE)
	$(hide) $(MD5SUM) $(HASH_TARGET_PACKAGE) | cut -d ' ' -f1 > $(HASH_TARGET_PACKAGE).md5sum
	@echo -e ""
	@echo -e "${cya}Building ${bldcya}HashOS ${txtrst}";
	@echo -e ""
	@echo -e ${CL_GRN}"              ▄█    █▄       ▄████████    ▄████████    ▄█    █▄     ▄██████▄     ▄████████          "
	@echo -e ${CL_GRN}"             ███    ███     ███    ███   ███    ███   ███    ███   ███    ███   ███    ███          "
	@echo -e ${CL_GRN}"             ███    ███     ███    ███   ███    █▀    ███    ███   ███    ███   ███    █▀           "
	@echo -e ${CL_GRN}"            ▄███▄▄▄▄███▄▄   ███    ███   ███         ▄███▄▄▄▄███▄▄ ███    ███   ███                 "
	@echo -e ${CL_GRN}"           ▀▀███▀▀▀▀███▀  ▀███████████ ▀███████████ ▀▀███▀▀▀▀███▀  ███    ███ ▀███████████          "
	@echo -e ${CL_GRN}"             ███    ███     ███    ███          ███   ███    ███   ███    ███          ███          "
	@echo -e ${CL_GRN}"             ███    ███     ███    ███    ▄█    ███   ███    ███   ███    ███    ▄█    ███          "
	@echo -e ${CL_GRN}"             ███    █▀      ███    █▀   ▄████████▀    ███    █▀     ▀██████▀   ▄████████▀           "
	@echo -e ""
	@echo -e ${CL_MAG}"zip: "${CL_CYN} $(HASH_TARGET_PACKAGE)${CL_RST}
	@echo -e ${CL_MAG}"md5: "${CL_CYN}" `cat $(HASH_TARGET_PACKAGE).md5sum | cut -d ' ' -f 1`"${CL_RST}
	@echo -e ${CL_MAG}"size:"${CL_CYN}" `ls -lah $(HASH_TARGET_PACKAGE) | cut -d ' ' -f 5`"${CL_RST}
	@echo -e ""

bacon: banana
