HASH_TARGET_PACKAGE := $(PRODUCT_OUT)/Hash-$(HASH_VERSION).zip

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
