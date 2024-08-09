/*
 Navicat MySQL Dump SQL

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 100432 (10.4.32-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : bullionfx

 Target Server Type    : MySQL
 Target Server Version : 100432 (10.4.32-MariaDB)
 File Encoding         : 65001

 Date: 08/08/2024 17:05:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for activity_logs
-- ----------------------------
DROP TABLE IF EXISTS `activity_logs`;
CREATE TABLE `activity_logs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `action` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `source` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `activity_logs_user_id_foreign`(`user_id` ASC) USING BTREE,
  CONSTRAINT `activity_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of activity_logs
-- ----------------------------

-- ----------------------------
-- Table structure for admin_banks
-- ----------------------------
DROP TABLE IF EXISTS `admin_banks`;
CREATE TABLE `admin_banks`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `unique_code` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `account_holder_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `account_holder_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bank_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bank_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `swift_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `iban` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `admin_banks_unique_code_unique`(`unique_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_banks
-- ----------------------------

-- ----------------------------
-- Table structure for admin_give_coin_histories
-- ----------------------------
DROP TABLE IF EXISTS `admin_give_coin_histories`;
CREATE TABLE `admin_give_coin_histories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `wallet_id` bigint NOT NULL,
  `amount` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_give_coin_histories
-- ----------------------------

-- ----------------------------
-- Table structure for admin_receive_token_transaction_histories
-- ----------------------------
DROP TABLE IF EXISTS `admin_receive_token_transaction_histories`;
CREATE TABLE `admin_receive_token_transaction_histories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `deposit_id` bigint NOT NULL,
  `type` tinyint NOT NULL DEFAULT 1,
  `unique_code` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `amount` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `fees` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `to_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `from_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `admin_receive_token_transaction_histories_unique_code_unique`(`unique_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_receive_token_transaction_histories
-- ----------------------------

-- ----------------------------
-- Table structure for admin_send_coin_histories
-- ----------------------------
DROP TABLE IF EXISTS `admin_send_coin_histories`;
CREATE TABLE `admin_send_coin_histories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `wallet_id` bigint NOT NULL,
  `amount` decimal(29, 18) NOT NULL,
  `updated_by` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_send_coin_histories
-- ----------------------------

-- ----------------------------
-- Table structure for admin_settings
-- ----------------------------
DROP TABLE IF EXISTS `admin_settings`;
CREATE TABLE `admin_settings`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 94 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_settings
-- ----------------------------
INSERT INTO `admin_settings` VALUES (1, 'exchange_url', '', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (2, 'coin_price', '2.50', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (3, 'coin_name', 'TradexPro', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (4, 'app_title', 'TradexPro Admin', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (5, 'maximum_withdrawal_daily', '3', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (6, 'mail_from', 'noreply@cpoket.com', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (7, 'admin_coin_address', 'address', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (8, 'base_coin_type', 'BTC', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (9, 'minimum_withdrawal_amount', '0.005', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (10, 'maximum_withdrawal_amount', '12', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (11, 'maintenance_mode', 'no', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (12, 'logo', '', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (13, 'login_logo', '', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (14, 'landing_logo', '', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (15, 'favicon', '', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (16, 'copyright_text', 'Copyright@2020', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (17, 'pagination_count', '10', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (18, 'point_rate', '1', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (19, 'currency', 'USD', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (20, 'lang', 'en', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (21, 'company_name', 'Test Company', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (22, 'primary_email', 'test@email.com', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (23, 'sms_getway_name', 'twillo', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (24, 'twillo_secret_key', 'test', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (25, 'twillo_auth_token', 'test', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (26, 'twillo_number', 'test', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (27, 'ssl_verify', '', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (28, 'mail_driver', 'SMTP', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (29, 'mail_host', 'smtp.mailtrap.io', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (30, 'mail_port', '2525', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (31, 'mail_username', 'kunzf13@gmail.com', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (32, 'mail_password', 'Password1!@#', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (33, 'mail_encryption', 'null', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (34, 'mail_from_address', 'mars1115@proton.me', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (35, 'braintree_client_token', 'test', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (36, 'braintree_environment', 'sandbox', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (37, 'braintree_merchant_id', 'test', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (38, 'braintree_public_key', 'test', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (39, 'braintree_private_key', 'test', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (40, 'clickatell_api_key', 'test', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (41, 'number_of_confirmation', '6', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (42, 'referral_commission_percentage', '10', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (43, 'referral_signup_reward', '10', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (44, 'max_affiliation_level', '3', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (45, 'coin_api_user', 'test', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (46, 'coin_api_pass', 'test', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (47, 'coin_api_host', 'test5', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (48, 'coin_api_port', 'test', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (49, 'COIN_PAYMENT_PUBLIC_KEY', 'test', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (50, 'COIN_PAYMENT_PRIVATE_KEY', 'test', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (51, 'COIN_PAYMENT_CURRENCY', 'BTC', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (52, 'ipn_merchant_id', '', '2022-08-16 09:46:21', '2022-08-16 09:46:21');
INSERT INTO `admin_settings` VALUES (53, 'ipn_secret', '', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (54, 'payment_method_coin_payment', '1', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (55, 'payment_method_bank_deposit', '1', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (56, 'chain_link', 'test', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (57, 'chain_id', 'test', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (58, 'contract_address', 'test', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (59, 'wallet_address', 'test', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (60, 'private_key', 'test', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (61, 'contract_decimal', '18', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (62, 'gas_limit', '216200', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (63, 'contract_coin_name', 'ETH', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (64, 'kyc_enable_for_withdrawal', '0', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (65, 'kyc_nid_enable_for_withdrawal', '0', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (66, 'kyc_passport_enable_for_withdrawal', '0', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (67, 'kyc_driving_enable_for_withdrawal', '0', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (68, 'trade_limit_1', '0', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (69, 'maker_1', '0', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (70, 'taker_1', '0', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (71, 'NOCAPTCHA_SECRET', 'test', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (72, 'NOCAPTCHA_SITEKEY', 'test', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (73, 'google_recapcha', '0', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (74, 'landing_title', '', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (75, 'landing_description', '', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (76, 'footer_description', '', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (77, 'landing_page_logo', '', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (78, 'landing_feature_title', '', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (79, 'market_trend_title', '', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (80, 'trade_anywhere_title', '', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (81, 'trade_anywhere_left_img', '', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (82, 'secure_trade_title', '', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (83, 'secure_trade_left_img', '', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (84, 'customization_title', '', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (85, 'customization_details', '', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (86, 'apple_store_link', '', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (87, 'android_store_link', '', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (88, 'google_store_link', '', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (89, 'macos_store_link', '', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (90, 'windows_store_link', '', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (91, 'linux_store_link', '', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (92, 'api_link', '', '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `admin_settings` VALUES (93, 'trading_price_tolerance', '10', '2022-08-16 09:46:22', '2022-08-16 09:46:22');

-- ----------------------------
-- Table structure for admin_wallet_deduct_histories
-- ----------------------------
DROP TABLE IF EXISTS `admin_wallet_deduct_histories`;
CREATE TABLE `admin_wallet_deduct_histories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `wallet_id` bigint UNSIGNED NOT NULL,
  `updated_by` bigint UNSIGNED NOT NULL,
  `old_balance` decimal(19, 8) UNSIGNED NOT NULL,
  `deduct_amount` decimal(19, 8) UNSIGNED NOT NULL,
  `new_balance` decimal(19, 8) UNSIGNED NOT NULL,
  `reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_wallet_deduct_histories
-- ----------------------------

-- ----------------------------
-- Table structure for affiliation_codes
-- ----------------------------
DROP TABLE IF EXISTS `affiliation_codes`;
CREATE TABLE `affiliation_codes`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `code` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `affiliation_codes_code_unique`(`code` ASC) USING BTREE,
  INDEX `affiliation_codes_user_id_foreign`(`user_id` ASC) USING BTREE,
  CONSTRAINT `affiliation_codes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of affiliation_codes
-- ----------------------------

-- ----------------------------
-- Table structure for affiliation_histories
-- ----------------------------
DROP TABLE IF EXISTS `affiliation_histories`;
CREATE TABLE `affiliation_histories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `child_id` bigint UNSIGNED NOT NULL,
  `amount` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `system_fees` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `transaction_id` bigint NULL DEFAULT NULL,
  `level` int NOT NULL,
  `order_type` int NULL DEFAULT NULL,
  `status` int NOT NULL DEFAULT 0,
  `coin_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `wallet_id` bigint NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `affiliation_histories_user_id_foreign`(`user_id` ASC) USING BTREE,
  INDEX `affiliation_histories_child_id_foreign`(`child_id` ASC) USING BTREE,
  CONSTRAINT `affiliation_histories_child_id_foreign` FOREIGN KEY (`child_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `affiliation_histories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of affiliation_histories
-- ----------------------------

-- ----------------------------
-- Table structure for announcements
-- ----------------------------
DROP TABLE IF EXISTS `announcements`;
CREATE TABLE `announcements`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of announcements
-- ----------------------------

-- ----------------------------
-- Table structure for banks
-- ----------------------------
DROP TABLE IF EXISTS `banks`;
CREATE TABLE `banks`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `account_holder_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `account_holder_address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bank_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bank_address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `country` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `swift_code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `iban` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of banks
-- ----------------------------

-- ----------------------------
-- Table structure for buy_coin_histories
-- ----------------------------
DROP TABLE IF EXISTS `buy_coin_histories`;
CREATE TABLE `buy_coin_histories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` tinyint NOT NULL,
  `user_id` bigint NOT NULL,
  `coin` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `btc` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `doller` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `transaction_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT 0,
  `admin_confirmation` tinyint NOT NULL DEFAULT 0,
  `confirmations` int NOT NULL DEFAULT 0,
  `bank_sleep` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bank_id` int NULL DEFAULT NULL,
  `coin_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phase_id` bigint NULL DEFAULT NULL,
  `referral_level` int NULL DEFAULT NULL,
  `fees` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `bonus` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `referral_bonus` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `requested_amount` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `stripe_token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of buy_coin_histories
-- ----------------------------

-- ----------------------------
-- Table structure for buy_coin_referral_histories
-- ----------------------------
DROP TABLE IF EXISTS `buy_coin_referral_histories`;
CREATE TABLE `buy_coin_referral_histories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `wallet_id` bigint NOT NULL,
  `buy_id` bigint NOT NULL,
  `phase_id` bigint NOT NULL,
  `child_id` bigint NOT NULL,
  `level` int NOT NULL,
  `system_fees` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `amount` decimal(13, 8) NOT NULL DEFAULT 0.00000000,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of buy_coin_referral_histories
-- ----------------------------

-- ----------------------------
-- Table structure for buys
-- ----------------------------
DROP TABLE IF EXISTS `buys`;
CREATE TABLE `buys`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `condition_buy_id` bigint UNSIGNED NULL DEFAULT NULL,
  `trade_coin_id` int NOT NULL,
  `base_coin_id` int NOT NULL,
  `amount` decimal(19, 8) UNSIGNED NOT NULL,
  `price` decimal(19, 8) UNSIGNED NOT NULL,
  `processed` decimal(19, 8) UNSIGNED NOT NULL DEFAULT 0.00000000,
  `virtual_amount` decimal(19, 8) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'false = pending, true = success',
  `btc_rate` decimal(19, 8) NOT NULL,
  `is_market` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = normal, 2 = active',
  `is_conditioned` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = simple buy & 1 = condition buy',
  `category` tinyint NOT NULL DEFAULT 1 COMMENT '1 = exchange',
  `maker_fees` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `taker_fees` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `request_amount` decimal(19, 8) UNSIGNED NOT NULL DEFAULT 0.00000000,
  `processed_request_amount` decimal(19, 8) UNSIGNED NOT NULL DEFAULT 0.00000000,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of buys
-- ----------------------------

-- ----------------------------
-- Table structure for co_wallet_withdraw_approvals
-- ----------------------------
DROP TABLE IF EXISTS `co_wallet_withdraw_approvals`;
CREATE TABLE `co_wallet_withdraw_approvals`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `temp_withdraw_id` bigint NOT NULL,
  `wallet_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of co_wallet_withdraw_approvals
-- ----------------------------

-- ----------------------------
-- Table structure for coin_pair_api_prices
-- ----------------------------
DROP TABLE IF EXISTS `coin_pair_api_prices`;
CREATE TABLE `coin_pair_api_prices`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `pair` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `buy_price` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `buy_amount` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `sell_price` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `sell_amount` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coin_pair_api_prices
-- ----------------------------

-- ----------------------------
-- Table structure for coin_pairs
-- ----------------------------
DROP TABLE IF EXISTS `coin_pairs`;
CREATE TABLE `coin_pairs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_coin_id` int NOT NULL,
  `child_coin_id` int NOT NULL,
  `value` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `volume` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `change` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `high` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `low` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `initial_price` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `price` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `status` tinyint NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `coin_pairs_parent_coin_id_child_coin_id_unique`(`parent_coin_id` ASC, `child_coin_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coin_pairs
-- ----------------------------

-- ----------------------------
-- Table structure for coin_payment_network_fees
-- ----------------------------
DROP TABLE IF EXISTS `coin_payment_network_fees`;
CREATE TABLE `coin_payment_network_fees`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `coin_type` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_fiat` tinyint NOT NULL DEFAULT 0,
  `last_update` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tx_fee` decimal(19, 8) NOT NULL,
  `rate_btc` decimal(29, 18) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coin_payment_network_fees
-- ----------------------------

-- ----------------------------
-- Table structure for coin_requests
-- ----------------------------
DROP TABLE IF EXISTS `coin_requests`;
CREATE TABLE `coin_requests`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `amount` decimal(13, 8) NOT NULL DEFAULT 0.00000000,
  `sender_user_id` bigint NOT NULL,
  `receiver_user_id` bigint NOT NULL,
  `sender_wallet_id` bigint NOT NULL,
  `receiver_wallet_id` bigint NOT NULL,
  `status` tinyint NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coin_requests
-- ----------------------------

-- ----------------------------
-- Table structure for coin_settings
-- ----------------------------
DROP TABLE IF EXISTS `coin_settings`;
CREATE TABLE `coin_settings`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `coin_id` bigint NOT NULL,
  `bitgo_wallet_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bitgo_webhook_label` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bitgo_webhook_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bitgo_webhook_url` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bitgo_webhook_numConfirmations` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bitgo_webhook_allToken` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bitgo_webhook_id` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bitgo_deleted_status` tinyint NOT NULL DEFAULT 0,
  `bitgo_approvalsRequired` tinyint NOT NULL DEFAULT 0,
  `bitgo_wallet_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bitgo_wallet` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `chain` int NOT NULL DEFAULT 1,
  `webhook_status` tinyint NOT NULL DEFAULT 0,
  `coin_api_user` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `gas_limit` int NULL DEFAULT NULL,
  `contract_decimal` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `wallet_key` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `wallet_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `contract_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `chain_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `chain_link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `contract_coin_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `coin_api_pass` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `coin_api_host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `coin_api_port` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `check_encrypt` tinyint NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coin_settings
-- ----------------------------

-- ----------------------------
-- Table structure for coins
-- ----------------------------
DROP TABLE IF EXISTS `coins`;
CREATE TABLE `coins`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `coin_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `network` tinyint NOT NULL DEFAULT 1,
  `is_withdrawal` tinyint NOT NULL DEFAULT 1,
  `is_deposit` tinyint NOT NULL DEFAULT 1,
  `is_buy` tinyint NOT NULL DEFAULT 1,
  `is_sell` tinyint NOT NULL DEFAULT 1,
  `coin_icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `is_base` tinyint(1) NOT NULL DEFAULT 1,
  `is_currency` tinyint(1) NOT NULL DEFAULT 0,
  `is_primary` tinyint(1) NULL DEFAULT NULL,
  `is_wallet` tinyint(1) NOT NULL DEFAULT 0,
  `is_transferable` tinyint(1) NOT NULL DEFAULT 0,
  `is_virtual_amount` tinyint(1) NOT NULL DEFAULT 0,
  `trade_status` tinyint NOT NULL DEFAULT 1,
  `sign` varchar(191) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `minimum_buy_amount` decimal(19, 8) NOT NULL DEFAULT 0.00000010,
  `maximum_buy_amount` decimal(19, 8) NOT NULL DEFAULT 999999.00000000,
  `minimum_sell_amount` decimal(19, 8) NOT NULL DEFAULT 0.00000010,
  `maximum_sell_amount` decimal(19, 8) NOT NULL DEFAULT 999999.00000000,
  `minimum_withdrawal` decimal(19, 8) NOT NULL DEFAULT 0.00000010,
  `maximum_withdrawal` decimal(19, 8) NOT NULL DEFAULT 99999999.00000000,
  `max_send_limit` decimal(19, 8) NOT NULL DEFAULT 99999999.00000000,
  `withdrawal_fees` decimal(29, 18) NOT NULL DEFAULT 0.000000100000000000,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `coins_coin_type_unique`(`coin_type` ASC) USING BTREE,
  UNIQUE INDEX `coins_is_primary_unique`(`is_primary` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coins
-- ----------------------------
INSERT INTO `coins` VALUES (1, 'Bitcoin', 'BTC', 1, 1, 1, 1, 1, 1, NULL, 1, 0, NULL, 0, 0, 0, 1, NULL, 0.00000010, 999999.00000000, 0.00000010, 999999.00000000, 0.00000010, 99999999.00000000, 99999999.00000000, 0.000000100000000000, '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `coins` VALUES (2, 'Tether USD', 'USDT', 1, 1, 1, 1, 1, 1, NULL, 1, 0, NULL, 0, 0, 0, 1, NULL, 0.00000010, 999999.00000000, 0.00000010, 999999.00000000, 0.00000010, 99999999.00000000, 99999999.00000000, 0.000000100000000000, '2022-08-16 09:46:22', '2022-08-16 09:46:22');

-- ----------------------------
-- Table structure for condition_buys
-- ----------------------------
DROP TABLE IF EXISTS `condition_buys`;
CREATE TABLE `condition_buys`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `trade_coin_id` int NOT NULL,
  `base_coin_id` int NOT NULL,
  `amount` decimal(19, 8) NOT NULL,
  `price` decimal(19, 8) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'false = pending, true = success',
  `btc_rate` decimal(19, 8) NOT NULL,
  `category` tinyint NOT NULL DEFAULT 1 COMMENT '1 = exchange',
  `maker_fees` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `taker_fees` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of condition_buys
-- ----------------------------

-- ----------------------------
-- Table structure for condition_sells
-- ----------------------------
DROP TABLE IF EXISTS `condition_sells`;
CREATE TABLE `condition_sells`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `condition_buy_id` bigint UNSIGNED NOT NULL,
  `trade_coin_id` int NOT NULL,
  `base_coin_id` int NOT NULL,
  `amount` decimal(19, 8) NOT NULL,
  `price` decimal(19, 8) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'false = pending, true = success',
  `btc_rate` decimal(19, 8) NOT NULL,
  `category` tinyint NOT NULL DEFAULT 1 COMMENT '1 = exchange',
  `maker_fees` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `taker_fees` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of condition_sells
-- ----------------------------

-- ----------------------------
-- Table structure for contact_us
-- ----------------------------
DROP TABLE IF EXISTS `contact_us`;
CREATE TABLE `contact_us`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contact_us
-- ----------------------------

-- ----------------------------
-- Table structure for country_lists
-- ----------------------------
DROP TABLE IF EXISTS `country_lists`;
CREATE TABLE `country_lists`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of country_lists
-- ----------------------------

-- ----------------------------
-- Table structure for currency_deposit_histories
-- ----------------------------
DROP TABLE IF EXISTS `currency_deposit_histories`;
CREATE TABLE `currency_deposit_histories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `payment_id` int UNSIGNED NOT NULL,
  `payment_type` tinyint UNSIGNED NOT NULL,
  `wallet_id` int UNSIGNED NOT NULL,
  `coin_id` int UNSIGNED NOT NULL,
  `coin_type` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bank_id` int UNSIGNED NULL DEFAULT NULL,
  `bank_recipt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `amount` decimal(29, 2) NOT NULL DEFAULT 0.00,
  `status` tinyint NOT NULL DEFAULT 0,
  `transaction_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of currency_deposit_histories
-- ----------------------------

-- ----------------------------
-- Table structure for currency_deposit_payment_methods
-- ----------------------------
DROP TABLE IF EXISTS `currency_deposit_payment_methods`;
CREATE TABLE `currency_deposit_payment_methods`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_method` tinyint NOT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fiat-deposit',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of currency_deposit_payment_methods
-- ----------------------------

-- ----------------------------
-- Table structure for currency_deposits
-- ----------------------------
DROP TABLE IF EXISTS `currency_deposits`;
CREATE TABLE `currency_deposits`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `unique_code` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint NOT NULL,
  `wallet_id` bigint NOT NULL,
  `from_wallet_id` bigint NULL DEFAULT NULL,
  `payment_method_id` bigint NOT NULL,
  `currency` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_amount` decimal(19, 8) NOT NULL,
  `coin_amount` decimal(19, 8) NOT NULL,
  `rate` decimal(19, 8) NOT NULL,
  `status` tinyint NOT NULL DEFAULT 0,
  `updated_by` bigint NULL DEFAULT NULL,
  `bank_receipt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bank_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `transaction_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `fees_type` tinyint NOT NULL DEFAULT 1,
  `fees` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `currency_deposits_unique_code_unique`(`unique_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of currency_deposits
-- ----------------------------

-- ----------------------------
-- Table structure for currency_lists
-- ----------------------------
DROP TABLE IF EXISTS `currency_lists`;
CREATE TABLE `currency_lists`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `symbol` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rate` decimal(19, 2) NOT NULL DEFAULT 1.00,
  `status` tinyint NOT NULL DEFAULT 1,
  `is_primary` tinyint NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `currency_lists_code_unique`(`code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of currency_lists
-- ----------------------------

-- ----------------------------
-- Table structure for currency_withdrawal_histories
-- ----------------------------
DROP TABLE IF EXISTS `currency_withdrawal_histories`;
CREATE TABLE `currency_withdrawal_histories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int UNSIGNED NOT NULL,
  `wallet_id` int UNSIGNED NOT NULL,
  `coin_id` int UNSIGNED NOT NULL,
  `bank_id` int UNSIGNED NOT NULL,
  `coin_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(29, 2) NOT NULL DEFAULT 0.00,
  `fees` decimal(29, 8) NOT NULL DEFAULT 0.00000000,
  `status` tinyint NOT NULL DEFAULT 0,
  `payment_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `receipt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of currency_withdrawal_histories
-- ----------------------------

-- ----------------------------
-- Table structure for custom_pages
-- ----------------------------
DROP TABLE IF EXISTS `custom_pages`;
CREATE TABLE `custom_pages`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` tinyint NOT NULL DEFAULT 1,
  `data_order` int NOT NULL DEFAULT 0,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of custom_pages
-- ----------------------------

-- ----------------------------
-- Table structure for deposite_transactions
-- ----------------------------
DROP TABLE IF EXISTS `deposite_transactions`;
CREATE TABLE `deposite_transactions`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fees` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `sender_wallet_id` bigint NULL DEFAULT NULL,
  `receiver_wallet_id` bigint UNSIGNED NOT NULL,
  `address_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `coin_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `amount` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `btc` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `doller` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `transaction_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0',
  `confirmations` int NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of deposite_transactions
-- ----------------------------

-- ----------------------------
-- Table structure for dynamic_menus
-- ----------------------------
DROP TABLE IF EXISTS `dynamic_menus`;
CREATE TABLE `dynamic_menus`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `parent_id` tinyint NULL DEFAULT NULL,
  `data_order` int NULL DEFAULT NULL,
  `status` tinyint NULL DEFAULT NULL,
  `login_type` tinyint NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dynamic_menus
-- ----------------------------

-- ----------------------------
-- Table structure for estimate_gas_fees_transaction_histories
-- ----------------------------
DROP TABLE IF EXISTS `estimate_gas_fees_transaction_histories`;
CREATE TABLE `estimate_gas_fees_transaction_histories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `unique_code` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `deposit_id` bigint NOT NULL,
  `type` tinyint NOT NULL DEFAULT 1,
  `wallet_id` bigint NOT NULL,
  `amount` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `fees` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `coin_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BTC',
  `admin_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `estimate_gas_fees_transaction_histories_unique_code_unique`(`unique_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of estimate_gas_fees_transaction_histories
-- ----------------------------

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for faq_types
-- ----------------------------
DROP TABLE IF EXISTS `faq_types`;
CREATE TABLE `faq_types`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of faq_types
-- ----------------------------

-- ----------------------------
-- Table structure for faqs
-- ----------------------------
DROP TABLE IF EXISTS `faqs`;
CREATE TABLE `faqs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `question` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `answer` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `author` bigint NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of faqs
-- ----------------------------
INSERT INTO `faqs` VALUES (1, 'What is Tradexpro exchange ?', 'Aenean condimentum nibh vel enim sodales scelerisque. Mauris quisn pellentesque odio, in vulputate turpis. Integer condimentum eni lorem pellentesque euismod. Nam rutrum accumsan nisl vulputate.', 1, 1, '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `faqs` VALUES (2, 'How it works ?', 'Aenean condimentum nibh vel enim sodales scelerisque. Mauris quisn pellentesque odio, in vulputate turpis. Integer condimentum eni lorem pellentesque euismod. Nam rutrum accumsan nisl vulputate.', 1, 1, '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `faqs` VALUES (3, 'What is the workflow ?', 'Aenean condimentum nibh vel enim sodales scelerisque. Mauris quisn pellentesque odio, in vulputate turpis. Integer condimentum eni lorem pellentesque euismod. Nam rutrum accumsan nisl vulputate.', 1, 1, '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `faqs` VALUES (4, 'How i place a order ?', 'Aenean condimentum nibh vel enim sodales scelerisque. Mauris quisn pellentesque odio, in vulputate turpis. Integer condimentum eni lorem pellentesque euismod. Nam rutrum accumsan nisl vulputate.', 1, 1, '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `faqs` VALUES (5, 'How i make a withdrawal ?', 'Aenean condimentum nibh vel enim sodales scelerisque. Mauris quisn pellentesque odio, in vulputate turpis. Integer condimentum eni lorem pellentesque euismod. Nam rutrum accumsan nisl vulputate.', 1, 1, '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `faqs` VALUES (6, 'What about the deposit process ?', 'Aenean condimentum nibh vel enim sodales scelerisque. Mauris quisn pellentesque odio, in vulputate turpis. Integer condimentum eni lorem pellentesque euismod. Nam rutrum accumsan nisl vulputate.', 1, 1, '2022-08-16 09:46:22', '2022-08-16 09:46:22');

-- ----------------------------
-- Table structure for favourite_coin_pairs
-- ----------------------------
DROP TABLE IF EXISTS `favourite_coin_pairs`;
CREATE TABLE `favourite_coin_pairs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `coin_pairs_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `favourite_coin_pairs_user_id_coin_pairs_id_unique`(`user_id` ASC, `coin_pairs_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of favourite_coin_pairs
-- ----------------------------

-- ----------------------------
-- Table structure for favourite_order_books
-- ----------------------------
DROP TABLE IF EXISTS `favourite_order_books`;
CREATE TABLE `favourite_order_books`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `base_coin_id` int NOT NULL,
  `trade_coin_id` int NOT NULL,
  `price` decimal(19, 8) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of favourite_order_books
-- ----------------------------

-- ----------------------------
-- Table structure for fiat_withdrawal_currencies
-- ----------------------------
DROP TABLE IF EXISTS `fiat_withdrawal_currencies`;
CREATE TABLE `fiat_withdrawal_currencies`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `currency_id` bigint NOT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fiat_withdrawal_currencies
-- ----------------------------

-- ----------------------------
-- Table structure for fiat_withdrawals
-- ----------------------------
DROP TABLE IF EXISTS `fiat_withdrawals`;
CREATE TABLE `fiat_withdrawals`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `bank_id` bigint UNSIGNED NOT NULL,
  `wallet_id` bigint UNSIGNED NOT NULL,
  `admin_id` bigint NULL DEFAULT NULL,
  `currency` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `coin_amount` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `currency_amount` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `rate` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `fees` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `bank_slip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT 0,
  `payment_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of fiat_withdrawals
-- ----------------------------

-- ----------------------------
-- Table structure for future_trade_balance_transfer_histories
-- ----------------------------
DROP TABLE IF EXISTS `future_trade_balance_transfer_histories`;
CREATE TABLE `future_trade_balance_transfer_histories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `spot_wallet_id` bigint UNSIGNED NOT NULL,
  `future_wallet_id` bigint UNSIGNED NOT NULL,
  `amount` decimal(19, 8) NOT NULL,
  `transfer_from` tinyint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of future_trade_balance_transfer_histories
-- ----------------------------

-- ----------------------------
-- Table structure for future_trade_long_shorts
-- ----------------------------
DROP TABLE IF EXISTS `future_trade_long_shorts`;
CREATE TABLE `future_trade_long_shorts`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `side` tinyint NOT NULL DEFAULT 1,
  `user_id` bigint UNSIGNED NOT NULL,
  `base_coin_id` bigint UNSIGNED NOT NULL,
  `trade_coin_id` bigint UNSIGNED NOT NULL,
  `parent_id` bigint UNSIGNED NULL DEFAULT NULL,
  `entry_price` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `exist_price` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `price` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `avg_close_price` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `pnl` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `amount_in_base_coin` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `amount_in_trade_coin` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `take_profit_price` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `stop_loss_price` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `liquidation_price` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `margin` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `fees` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `comission` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `executed_amount` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `leverage` int NOT NULL DEFAULT 0,
  `margin_mode` tinyint NOT NULL DEFAULT 1,
  `trade_type` tinyint NOT NULL DEFAULT 1,
  `is_position` tinyint NOT NULL DEFAULT 0,
  `future_trade_time` datetime NULL DEFAULT NULL,
  `closed_time` datetime NULL DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT 0,
  `is_market` tinyint NOT NULL DEFAULT 0,
  `order_type` tinyint NOT NULL DEFAULT 1,
  `stop_price` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `trigger_condition` tinyint NOT NULL DEFAULT 0,
  `current_market_price` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `future_trade_long_shorts_uid_unique`(`uid` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of future_trade_long_shorts
-- ----------------------------

-- ----------------------------
-- Table structure for future_trade_transaction_histories
-- ----------------------------
DROP TABLE IF EXISTS `future_trade_transaction_histories`;
CREATE TABLE `future_trade_transaction_histories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED NULL DEFAULT NULL,
  `future_wallet_id` bigint UNSIGNED NULL DEFAULT NULL,
  `coin_pair_id` bigint UNSIGNED NULL DEFAULT NULL,
  `type` tinyint NULL DEFAULT NULL,
  `amount` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `coin_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `symbol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of future_trade_transaction_histories
-- ----------------------------

-- ----------------------------
-- Table structure for future_wallets
-- ----------------------------
DROP TABLE IF EXISTS `future_wallets`;
CREATE TABLE `future_wallets`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `wallet_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `coin_id` bigint UNSIGNED NOT NULL,
  `coin_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `balance` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of future_wallets
-- ----------------------------

-- ----------------------------
-- Table structure for gift_card_banners
-- ----------------------------
DROP TABLE IF EXISTS `gift_card_banners`;
CREATE TABLE `gift_card_banners`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sub_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `banner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `updated_by` int UNSIGNED NOT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gift_card_banners
-- ----------------------------

-- ----------------------------
-- Table structure for gift_card_categories
-- ----------------------------
DROP TABLE IF EXISTS `gift_card_categories`;
CREATE TABLE `gift_card_categories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gift_card_categories
-- ----------------------------

-- ----------------------------
-- Table structure for gift_card_redeem_histories
-- ----------------------------
DROP TABLE IF EXISTS `gift_card_redeem_histories`;
CREATE TABLE `gift_card_redeem_histories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `gift_card_id` int UNSIGNED NOT NULL,
  `receiver_id` int UNSIGNED NOT NULL,
  `coin_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `status` tinyint NOT NULL DEFAULT 1,
  `updated_by` int UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gift_card_redeem_histories
-- ----------------------------

-- ----------------------------
-- Table structure for gift_cards
-- ----------------------------
DROP TABLE IF EXISTS `gift_cards`;
CREATE TABLE `gift_cards`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `gift_card_banner_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `coin_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `wallet_type` int UNSIGNED NOT NULL,
  `amount` decimal(29, 18) NOT NULL,
  `fees` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `redeem_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `owner_id` bigint UNSIGNED NULL DEFAULT NULL,
  `is_ads_created` tinyint NOT NULL DEFAULT 0,
  `lock` tinyint NOT NULL DEFAULT 0,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `gift_cards_redeem_code_unique`(`redeem_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gift_cards
-- ----------------------------

-- ----------------------------
-- Table structure for ico_phases
-- ----------------------------
DROP TABLE IF EXISTS `ico_phases`;
CREATE TABLE `ico_phases`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `phase_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `start_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `fees` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `rate` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `amount` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `bonus` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `status` tinyint NOT NULL DEFAULT 1,
  `affiliation_level` int NULL DEFAULT NULL,
  `affiliation_percentage` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ico_phases
-- ----------------------------

-- ----------------------------
-- Table structure for job_batches
-- ----------------------------
DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `cancelled_at` int NULL DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of job_batches
-- ----------------------------

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED NULL DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `jobs_queue_index`(`queue` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jobs
-- ----------------------------

-- ----------------------------
-- Table structure for kyc_lists
-- ----------------------------
DROP TABLE IF EXISTS `kyc_lists`;
CREATE TABLE `kyc_lists`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `type` tinyint NULL DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kyc_lists
-- ----------------------------

-- ----------------------------
-- Table structure for landing_banners
-- ----------------------------
DROP TABLE IF EXISTS `landing_banners`;
CREATE TABLE `landing_banners`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of landing_banners
-- ----------------------------

-- ----------------------------
-- Table structure for landing_features
-- ----------------------------
DROP TABLE IF EXISTS `landing_features`;
CREATE TABLE `landing_features`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `feature_title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `feature_icon` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of landing_features
-- ----------------------------

-- ----------------------------
-- Table structure for lang_names
-- ----------------------------
DROP TABLE IF EXISTS `lang_names`;
CREATE TABLE `lang_names`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `key` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lang_names
-- ----------------------------

-- ----------------------------
-- Table structure for languages
-- ----------------------------
DROP TABLE IF EXISTS `languages`;
CREATE TABLE `languages`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `language` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of languages
-- ----------------------------
INSERT INTO `languages` VALUES (1, NULL, 'en', '2022-08-16 09:46:17', '2022-08-16 09:46:17');

-- ----------------------------
-- Table structure for membership_bonus_distribution_histories
-- ----------------------------
DROP TABLE IF EXISTS `membership_bonus_distribution_histories`;
CREATE TABLE `membership_bonus_distribution_histories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `plan_id` bigint NOT NULL,
  `wallet_id` bigint NOT NULL,
  `membership_id` bigint NOT NULL,
  `distribution_date` date NOT NULL,
  `bonus_coin_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BTC',
  `bonus_amount_btc` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `bonus_amount` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `plan_current_bonus` decimal(13, 8) NOT NULL DEFAULT 0.00000000,
  `bonus_type` tinyint NOT NULL DEFAULT 0,
  `status` tinyint NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of membership_bonus_distribution_histories
-- ----------------------------

-- ----------------------------
-- Table structure for membership_bonuses
-- ----------------------------
DROP TABLE IF EXISTS `membership_bonuses`;
CREATE TABLE `membership_bonuses`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `bonus_amount` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of membership_bonuses
-- ----------------------------

-- ----------------------------
-- Table structure for membership_clubs
-- ----------------------------
DROP TABLE IF EXISTS `membership_clubs`;
CREATE TABLE `membership_clubs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `plan_id` bigint NOT NULL,
  `wallet_id` bigint NOT NULL,
  `coin_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `start_date` date NULL DEFAULT NULL,
  `end_date` date NULL DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of membership_clubs
-- ----------------------------

-- ----------------------------
-- Table structure for membership_plans
-- ----------------------------
DROP TABLE IF EXISTS `membership_plans`;
CREATE TABLE `membership_plans`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `plan_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration` int NOT NULL DEFAULT 0,
  `amount` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `image` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bonus_type` tinyint NOT NULL DEFAULT 1,
  `bonus` decimal(13, 8) NOT NULL DEFAULT 0.00000000,
  `status` tinyint NOT NULL DEFAULT 1,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of membership_plans
-- ----------------------------

-- ----------------------------
-- Table structure for membership_transaction_histories
-- ----------------------------
DROP TABLE IF EXISTS `membership_transaction_histories`;
CREATE TABLE `membership_transaction_histories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `club_id` bigint NULL DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `wallet_id` bigint NOT NULL,
  `coin_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `type` tinyint NOT NULL DEFAULT 1,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of membership_transaction_histories
-- ----------------------------

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 76 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO `migrations` VALUES (3, '2016_06_01_000001_create_oauth_auth_codes_table', 1);
INSERT INTO `migrations` VALUES (4, '2016_06_01_000002_create_oauth_access_tokens_table', 1);
INSERT INTO `migrations` VALUES (5, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1);
INSERT INTO `migrations` VALUES (6, '2016_06_01_000004_create_oauth_clients_table', 1);
INSERT INTO `migrations` VALUES (7, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1);
INSERT INTO `migrations` VALUES (8, '2018_08_29_200844_create_languages_table', 1);
INSERT INTO `migrations` VALUES (9, '2018_08_29_205156_create_translations_table', 1);
INSERT INTO `migrations` VALUES (10, '2019_06_24_092552_create_wallets_table', 1);
INSERT INTO `migrations` VALUES (11, '2019_07_24_092303_create_user_settings_table', 1);
INSERT INTO `migrations` VALUES (12, '2019_07_24_092331_create_admin_settings_table', 1);
INSERT INTO `migrations` VALUES (13, '2019_07_24_092409_create_activity_logs_table', 1);
INSERT INTO `migrations` VALUES (14, '2019_07_24_092511_create_wallet_address_histories_table', 1);
INSERT INTO `migrations` VALUES (15, '2019_07_24_103207_create_user_verification_codes_table', 1);
INSERT INTO `migrations` VALUES (16, '2019_10_17_075927_create_affiliation_codes_table', 1);
INSERT INTO `migrations` VALUES (17, '2019_10_17_080002_create_affiliation_histories_table', 1);
INSERT INTO `migrations` VALUES (18, '2019_10_17_080031_create_referral_users_table', 1);
INSERT INTO `migrations` VALUES (20, '2020_04_29_080822_create_verification_details_table', 1);
INSERT INTO `migrations` VALUES (21, '2020_04_29_081029_create_banks_table', 1);
INSERT INTO `migrations` VALUES (22, '2020_04_29_081134_create_buy_coin_histories_table', 1);
INSERT INTO `migrations` VALUES (23, '2020_04_29_081343_create_deposite_transactions_table', 1);
INSERT INTO `migrations` VALUES (24, '2020_04_29_081451_create_withdraw_histories_table', 1);
INSERT INTO `migrations` VALUES (25, '2020_06_11_133803_create_membership_clubs_table', 1);
INSERT INTO `migrations` VALUES (26, '2020_06_11_134228_create_membership_plans_table', 1);
INSERT INTO `migrations` VALUES (27, '2020_06_11_134611_create_membership_bonuses_table', 1);
INSERT INTO `migrations` VALUES (28, '2020_06_11_134742_create_membership_bonus_distribution_histories_table', 1);
INSERT INTO `migrations` VALUES (29, '2020_06_11_134823_create_membership_transaction_histories_table', 1);
INSERT INTO `migrations` VALUES (30, '2020_06_17_123519_create_faqs_table', 1);
INSERT INTO `migrations` VALUES (31, '2020_06_19_095619_create_send_mail_records_table', 1);
INSERT INTO `migrations` VALUES (32, '2020_06_19_183647_create_notifications_table', 1);
INSERT INTO `migrations` VALUES (33, '2020_06_21_152330_create_referral_sign_bonus_histories_table', 1);
INSERT INTO `migrations` VALUES (34, '2020_06_24_080256_create_websockets_statistics_entries_table', 1);
INSERT INTO `migrations` VALUES (35, '2020_07_01_111249_create_admin_give_coin_histories_table', 1);
INSERT INTO `migrations` VALUES (36, '2020_07_03_092949_create_ico_phases_table', 1);
INSERT INTO `migrations` VALUES (37, '2020_07_06_053213_create_buy_coin_referral_histories_table', 1);
INSERT INTO `migrations` VALUES (38, '2020_07_26_091257_create_coin_requests_table', 1);
INSERT INTO `migrations` VALUES (39, '2020_09_25_105747_create_coins_table', 1);
INSERT INTO `migrations` VALUES (40, '2021_01_13_093659_create_custom_pages_table', 1);
INSERT INTO `migrations` VALUES (41, '2021_01_16_064548_create_contact_us_table', 1);
INSERT INTO `migrations` VALUES (42, '2021_03_04_065920_create_wallet_swap_histories_table', 1);
INSERT INTO `migrations` VALUES (43, '2021_04_19_124055_create_wallet_co_users_table', 1);
INSERT INTO `migrations` VALUES (44, '2021_04_19_125002_create_temp_withdraws_table', 1);
INSERT INTO `migrations` VALUES (45, '2021_04_19_125104_create_co_wallet_withdraw_approvals_table', 1);
INSERT INTO `migrations` VALUES (46, '2021_04_21_093136_create_coin_pairs_table', 1);
INSERT INTO `migrations` VALUES (47, '2021_04_21_102458_create_selected_coin_pairs_table', 1);
INSERT INTO `migrations` VALUES (48, '2021_04_26_072220_create_favourite_coin_pairs_table', 1);
INSERT INTO `migrations` VALUES (49, '2021_04_26_083147_visual_number_format', 1);
INSERT INTO `migrations` VALUES (50, '2021_04_30_083147_create_buys_table', 1);
INSERT INTO `migrations` VALUES (51, '2021_04_30_083148_create_sells_table', 1);
INSERT INTO `migrations` VALUES (52, '2021_04_30_083149_create_transactions_table', 1);
INSERT INTO `migrations` VALUES (53, '2021_04_30_083288_buy_process_not_big_than_amount', 1);
INSERT INTO `migrations` VALUES (54, '2021_04_30_084147_update_transaction_last_price', 1);
INSERT INTO `migrations` VALUES (55, '2021_04_30_085147_sell_process_not_big_than_amount', 1);
INSERT INTO `migrations` VALUES (56, '2021_04_30_086722_create_favourite_order_books_table', 1);
INSERT INTO `migrations` VALUES (57, '2021_05_31_084035_create_condition_buys_table', 1);
INSERT INTO `migrations` VALUES (58, '2021_05_31_084049_create_condition_sells_table', 1);
INSERT INTO `migrations` VALUES (59, '2021_05_31_084657_create_stop_limits_table', 1);
INSERT INTO `migrations` VALUES (60, '2021_11_14_100847_create_tv_chart_15min_table', 1);
INSERT INTO `migrations` VALUES (61, '2021_11_14_100847_create_tv_chart_1day_table', 1);
INSERT INTO `migrations` VALUES (62, '2021_11_14_100847_create_tv_chart_2hours_table', 1);
INSERT INTO `migrations` VALUES (63, '2021_11_14_100847_create_tv_chart_30min_table', 1);
INSERT INTO `migrations` VALUES (64, '2021_11_14_100847_create_tv_chart_4hours_table', 1);
INSERT INTO `migrations` VALUES (65, '2021_11_14_100847_create_tv_chart_5min_table', 1);
INSERT INTO `migrations` VALUES (66, '2021_12_31_100100_create_landing_banners_table', 1);
INSERT INTO `migrations` VALUES (67, '2021_12_31_100126_create_announcements_table', 1);
INSERT INTO `migrations` VALUES (68, '2022_05_05_052425_create_social_media_table', 1);
INSERT INTO `migrations` VALUES (69, '2022_05_05_052840_create_landing_features_table', 1);
INSERT INTO `migrations` VALUES (70, '2022_08_03_074054_add_type_at_custom_page', 1);
INSERT INTO `migrations` VALUES (71, '0001_01_01_000001_create_cache_table', 2);
INSERT INTO `migrations` VALUES (72, '0001_01_01_000002_create_jobs_table', 3);
INSERT INTO `migrations` VALUES (73, '2024_08_07_084959_add_nickname_to_users_table', 4);
INSERT INTO `migrations` VALUES (74, '2024_08_07_091955_add_api_access_allow_to_users_table', 5);
INSERT INTO `migrations` VALUES (75, '2024_08_07_161049_create_personal_access_tokens_table', 6);

-- ----------------------------
-- Table structure for notifications
-- ----------------------------
DROP TABLE IF EXISTS `notifications`;
CREATE TABLE `notifications`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `notification_body` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `type` tinyint NOT NULL DEFAULT 1,
  `status` tinyint NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notifications
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE `oauth_access_tokens`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_access_tokens_user_id_index`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_access_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_auth_codes
-- ----------------------------
DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE `oauth_auth_codes`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `client_id` bigint UNSIGNED NOT NULL,
  `scopes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_auth_codes_user_id_index`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_auth_codes
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_clients
-- ----------------------------
DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE `oauth_clients`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `provider` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `redirect` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_clients_user_id_index`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_clients
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_personal_access_clients
-- ----------------------------
DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE `oauth_personal_access_clients`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_personal_access_clients
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_refresh_tokens
-- ----------------------------
DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE `oauth_refresh_tokens`  (
  `id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `oauth_refresh_tokens_access_token_id_index`(`access_token_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oauth_refresh_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for password_reset_tokens
-- ----------------------------
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens`  (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of password_reset_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets`  (
  `email` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  INDEX `password_resets_email_index`(`email` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of password_resets
-- ----------------------------

-- ----------------------------
-- Table structure for permission_from_data
-- ----------------------------
DROP TABLE IF EXISTS `permission_from_data`;
CREATE TABLE `permission_from_data`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `group` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `for` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `route` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permission_from_data
-- ----------------------------

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` int UNSIGNED NOT NULL,
  `action_id` int UNSIGNED NULL DEFAULT NULL,
  `group` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `route` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permissions
-- ----------------------------

-- ----------------------------
-- Table structure for personal_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `personal_access_tokens_token_unique`(`token` ASC) USING BTREE,
  INDEX `personal_access_tokens_tokenable_type_tokenable_id_index`(`tokenable_type` ASC, `tokenable_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of personal_access_tokens
-- ----------------------------
INSERT INTO `personal_access_tokens` VALUES (1, 'App\\Models\\User', 65, 'kunzf13@gmail.com', 'a76e5a209d00cee6d508528f789059c699bd329e0a0438d67e7f33be87bb40ff', '[\"*\"]', NULL, NULL, '2024-08-08 14:28:23', '2024-08-08 14:28:23');
INSERT INTO `personal_access_tokens` VALUES (2, 'App\\Models\\User', 66, 'fasdf@sdfsdf.com', 'd1a1885fe20ae5fe4bef6f502077c070258c3981ed42cdef217189302d2d2809', '[\"*\"]', NULL, NULL, '2024-08-08 14:33:45', '2024-08-08 14:33:45');
INSERT INTO `personal_access_tokens` VALUES (3, 'App\\Models\\User', 65, 'kunzf13@gmail.com', '3cec5c1358aafe75ddc687484c3d29561339231423b39f37d534d22200082372', '[\"*\"]', NULL, NULL, '2024-08-08 14:34:29', '2024-08-08 14:34:29');

-- ----------------------------
-- Table structure for progress_statuses
-- ----------------------------
DROP TABLE IF EXISTS `progress_statuses`;
CREATE TABLE `progress_statuses`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` tinyint NULL DEFAULT NULL,
  `progress_type_id` tinyint NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of progress_statuses
-- ----------------------------

-- ----------------------------
-- Table structure for referral_sign_bonus_histories
-- ----------------------------
DROP TABLE IF EXISTS `referral_sign_bonus_histories`;
CREATE TABLE `referral_sign_bonus_histories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `parent_id` bigint NOT NULL,
  `wallet_id` bigint NOT NULL,
  `amount` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of referral_sign_bonus_histories
-- ----------------------------

-- ----------------------------
-- Table structure for referral_users
-- ----------------------------
DROP TABLE IF EXISTS `referral_users`;
CREATE TABLE `referral_users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `parent_id` bigint UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `referral_users_user_id_unique`(`user_id` ASC) USING BTREE,
  INDEX `referral_users_parent_id_foreign`(`parent_id` ASC) USING BTREE,
  CONSTRAINT `referral_users_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `referral_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of referral_users
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------

-- ----------------------------
-- Table structure for selected_coin_pairs
-- ----------------------------
DROP TABLE IF EXISTS `selected_coin_pairs`;
CREATE TABLE `selected_coin_pairs`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `base_coin_id` int NOT NULL,
  `trade_coin_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `selected_coin_pairs_base_coin_id_user_id_trade_coin_id_unique`(`base_coin_id` ASC, `user_id` ASC, `trade_coin_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of selected_coin_pairs
-- ----------------------------

-- ----------------------------
-- Table structure for sells
-- ----------------------------
DROP TABLE IF EXISTS `sells`;
CREATE TABLE `sells`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `condition_buy_id` bigint UNSIGNED NULL DEFAULT NULL,
  `trade_coin_id` int NOT NULL,
  `base_coin_id` int NOT NULL,
  `amount` decimal(19, 8) UNSIGNED NOT NULL,
  `price` decimal(19, 8) UNSIGNED NOT NULL,
  `processed` decimal(19, 8) UNSIGNED NOT NULL DEFAULT 0.00000000,
  `virtual_amount` decimal(19, 8) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'false = pending, true = success',
  `btc_rate` decimal(19, 8) NOT NULL,
  `is_market` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = normal, 2 = active',
  `is_conditioned` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 = simple buy & 1 = condition buy',
  `category` tinyint NOT NULL DEFAULT 1 COMMENT '1 = exchange',
  `maker_fees` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `taker_fees` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sells
-- ----------------------------

-- ----------------------------
-- Table structure for send_mail_records
-- ----------------------------
DROP TABLE IF EXISTS `send_mail_records`;
CREATE TABLE `send_mail_records`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `email_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of send_mail_records
-- ----------------------------

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sessions_user_id_index`(`user_id` ASC) USING BTREE,
  INDEX `sessions_last_activity_index`(`last_activity` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sessions
-- ----------------------------
INSERT INTO `sessions` VALUES ('B3rjXbKQel85NFAS2YWBbQA8gKPLULdcFMIJr0Kz', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZlhmR3laSklBeUo5VnZjZG9HWmxvM2hEdkI4cmtjbXNySnhFOUZJdCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hZG1pbi91c2VycyI7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7fQ==', 1723113770);
INSERT INTO `sessions` VALUES ('DNqERE8sEDw1S2LOpQT6jDdJZ1Qv8KTyotpAOrfj', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoielFiYW5jUk5YSzNURXlYM3l1VTd0Uk5qM1dJUnQySGhodGZCRWx3RCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozNzoiaHR0cDovL2xvY2FsaG9zdDo4MDAwL2FkbWluL2Rhc2hib2FyZCI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMzOiJodHRwOi8vbG9jYWxob3N0OjgwMDAvYWRtaW4vdXNlcnMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1723098115);
INSERT INTO `sessions` VALUES ('Hw08bmkuyuwmzoRWm4q2wKfPZcabvTZPdKnOs5ik', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiQTZRdXNjd1oxbGdKNnljWlFTdFpicmkwR2x2NlNzY2VUSmNjSks3OSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMzoiaHR0cDovL2xvY2FsaG9zdDo4MDAwL2FkbWluL3VzZXJzIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hc3NldHMvbGFuZGluZy9pbWFnZXMvZmF2LnBuZyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjE6e2k6MDtzOjc6InN1Y2Nlc3MiO31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czo3OiJzdWNjZXNzIjtzOjE2OiJMb2dpbiBzdWNjZXNzZnVsIjt9', 1723107030);
INSERT INTO `sessions` VALUES ('MWMTzskUk4Qda2rFCWjPSOG1n2pHiLZJp5xhZuWV', NULL, '127.0.0.1', 'PostmanRuntime/7.40.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVWViS1NmNVZyN1RUaTRuQThuNDhxS3FWMnpacnlZdmxjeWhNNEQzWCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1723091625);
INSERT INTO `sessions` VALUES ('XemcpVKOTTxqWfH3I0qTMP82Dg2s4KDT5VALDBax', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiSVYwOXZEcWQzZUZFTWxJVTRGeWJFMUp1RjJGYVM1THZCeTlvNWdPTiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMzoiaHR0cDovL2xvY2FsaG9zdDo4MDAwL2FkbWluL3VzZXJzIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hZG1pbi91c2VycyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7fQ==', 1723127614);

-- ----------------------------
-- Table structure for social_media
-- ----------------------------
DROP TABLE IF EXISTS `social_media`;
CREATE TABLE `social_media`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `media_title` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `media_link` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `media_icon` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of social_media
-- ----------------------------

-- ----------------------------
-- Table structure for staking_investment_payments
-- ----------------------------
DROP TABLE IF EXISTS `staking_investment_payments`;
CREATE TABLE `staking_investment_payments`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `staking_investment_id` bigint UNSIGNED NOT NULL,
  `wallet_id` bigint UNSIGNED NOT NULL,
  `coin_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_auto_renew` tinyint NOT NULL DEFAULT 0,
  `total_investment` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `total_bonus` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `total_amount` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `investment_status` tinyint NOT NULL DEFAULT 5,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `staking_investment_payments_uid_unique`(`uid` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of staking_investment_payments
-- ----------------------------

-- ----------------------------
-- Table structure for staking_investments
-- ----------------------------
DROP TABLE IF EXISTS `staking_investments`;
CREATE TABLE `staking_investments`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `staking_offer_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `coin_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `period` int UNSIGNED NOT NULL,
  `offer_percentage` decimal(19, 8) NOT NULL,
  `terms_type` tinyint NOT NULL,
  `minimum_maturity_period` int NOT NULL,
  `auto_renew_status` tinyint NOT NULL DEFAULT 0,
  `status` tinyint NOT NULL DEFAULT 1,
  `investment_amount` decimal(19, 8) NOT NULL,
  `earn_daily_bonus` decimal(19, 8) NOT NULL,
  `total_bonus` decimal(19, 8) NOT NULL,
  `auto_renew_from` bigint UNSIGNED NULL DEFAULT NULL,
  `is_auto_renew` tinyint NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `staking_investments_uid_unique`(`uid` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of staking_investments
-- ----------------------------

-- ----------------------------
-- Table structure for staking_offers
-- ----------------------------
DROP TABLE IF EXISTS `staking_offers`;
CREATE TABLE `staking_offers`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by` bigint UNSIGNED NOT NULL,
  `coin_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `period` int UNSIGNED NOT NULL,
  `offer_percentage` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `minimum_investment` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `maximum_investment` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `terms_type` tinyint NOT NULL DEFAULT 1,
  `minimum_maturity_period` int NOT NULL DEFAULT 0,
  `terms_condition` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `registration_before` int NOT NULL DEFAULT 0,
  `phone_verification` tinyint NOT NULL DEFAULT 0,
  `kyc_verification` tinyint NOT NULL DEFAULT 0,
  `user_minimum_holding_amount` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `staking_offers_uid_unique`(`uid` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of staking_offers
-- ----------------------------

-- ----------------------------
-- Table structure for stop_limits
-- ----------------------------
DROP TABLE IF EXISTS `stop_limits`;
CREATE TABLE `stop_limits`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `condition_buy_id` bigint UNSIGNED NULL DEFAULT NULL,
  `trade_coin_id` int NOT NULL,
  `base_coin_id` int NOT NULL,
  `stop` decimal(19, 8) NOT NULL,
  `limit_price` decimal(19, 8) NOT NULL,
  `amount` decimal(19, 8) NOT NULL,
  `order` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_conditioned` tinyint NOT NULL DEFAULT 0 COMMENT '0 = simple stop limits, 1 = advanced stop limit',
  `category` tinyint NOT NULL DEFAULT 1 COMMENT '1 = exchange',
  `maker_fees` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `taker_fees` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `status` tinyint NOT NULL DEFAULT 0,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stop_limits
-- ----------------------------

-- ----------------------------
-- Table structure for temp_withdraws
-- ----------------------------
DROP TABLE IF EXISTS `temp_withdraws`;
CREATE TABLE `temp_withdraws`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `wallet_id` bigint NOT NULL,
  `withdraw_id` bigint NULL DEFAULT NULL,
  `amount` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` tinyint NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of temp_withdraws
-- ----------------------------

-- ----------------------------
-- Table structure for third_party_kyc_details
-- ----------------------------
DROP TABLE IF EXISTS `third_party_kyc_details`;
CREATE TABLE `third_party_kyc_details`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `kyc_type` tinyint NULL DEFAULT NULL,
  `is_verified` tinyint NOT NULL DEFAULT 0,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of third_party_kyc_details
-- ----------------------------

-- ----------------------------
-- Table structure for trade_referral_histories
-- ----------------------------
DROP TABLE IF EXISTS `trade_referral_histories`;
CREATE TABLE `trade_referral_histories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `trade_by` bigint UNSIGNED NULL DEFAULT NULL,
  `user_id` bigint UNSIGNED NULL DEFAULT NULL,
  `child_id` bigint UNSIGNED NULL DEFAULT NULL,
  `amount` decimal(19, 8) UNSIGNED NOT NULL,
  `percentage_amount` tinyint NULL DEFAULT NULL,
  `transaction_id` bigint UNSIGNED NULL DEFAULT NULL,
  `level` tinyint NULL DEFAULT NULL,
  `coin_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `wallet_id` bigint UNSIGNED NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of trade_referral_histories
-- ----------------------------

-- ----------------------------
-- Table structure for transactions
-- ----------------------------
DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `transaction_id` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `base_coin_id` int UNSIGNED NOT NULL,
  `trade_coin_id` int UNSIGNED NOT NULL,
  `buy_id` bigint UNSIGNED NOT NULL COMMENT 'exchange_buy_id',
  `sell_id` bigint UNSIGNED NOT NULL COMMENT 'exchange_sell_id',
  `buy_user_id` bigint UNSIGNED NOT NULL,
  `sell_user_id` bigint UNSIGNED NOT NULL,
  `price_order_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `amount` decimal(19, 8) UNSIGNED NOT NULL,
  `price` decimal(19, 8) UNSIGNED NOT NULL,
  `last_price` decimal(19, 8) UNSIGNED NULL DEFAULT NULL,
  `btc_rate` decimal(19, 8) UNSIGNED NOT NULL,
  `btc` decimal(19, 8) UNSIGNED NOT NULL,
  `total` decimal(29, 18) UNSIGNED NOT NULL,
  `buy_fees` decimal(29, 18) UNSIGNED NOT NULL,
  `sell_fees` decimal(29, 18) UNSIGNED NOT NULL,
  `remove_from_chart` tinyint(1) NOT NULL DEFAULT 0,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of transactions
-- ----------------------------

-- ----------------------------
-- Table structure for translations
-- ----------------------------
DROP TABLE IF EXISTS `translations`;
CREATE TABLE `translations`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_id` int UNSIGNED NOT NULL,
  `group` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `key` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `translations_language_id_foreign`(`language_id` ASC) USING BTREE,
  CONSTRAINT `translations_language_id_foreign` FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of translations
-- ----------------------------

-- ----------------------------
-- Table structure for tv_chart_15mins
-- ----------------------------
DROP TABLE IF EXISTS `tv_chart_15mins`;
CREATE TABLE `tv_chart_15mins`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `interval` int UNSIGNED NOT NULL,
  `base_coin_id` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `trade_coin_id` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `open` decimal(19, 8) NOT NULL,
  `close` decimal(19, 8) NOT NULL,
  `high` decimal(19, 8) NOT NULL,
  `low` decimal(19, 8) NOT NULL,
  `volume` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `tv_chart_15mins_base_coin_id_trade_coin_id_interval_unique`(`base_coin_id` ASC, `trade_coin_id` ASC, `interval` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tv_chart_15mins
-- ----------------------------

-- ----------------------------
-- Table structure for tv_chart_1days
-- ----------------------------
DROP TABLE IF EXISTS `tv_chart_1days`;
CREATE TABLE `tv_chart_1days`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `interval` int UNSIGNED NOT NULL,
  `base_coin_id` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `trade_coin_id` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `open` decimal(19, 8) NOT NULL,
  `close` decimal(19, 8) NOT NULL,
  `high` decimal(19, 8) NOT NULL,
  `low` decimal(19, 8) NOT NULL,
  `volume` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `tv_chart_1days_base_coin_id_trade_coin_id_interval_unique`(`base_coin_id` ASC, `trade_coin_id` ASC, `interval` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tv_chart_1days
-- ----------------------------

-- ----------------------------
-- Table structure for tv_chart_2hours
-- ----------------------------
DROP TABLE IF EXISTS `tv_chart_2hours`;
CREATE TABLE `tv_chart_2hours`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `interval` int UNSIGNED NOT NULL,
  `base_coin_id` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `trade_coin_id` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `open` decimal(19, 8) NOT NULL,
  `close` decimal(19, 8) NOT NULL,
  `high` decimal(19, 8) NOT NULL,
  `low` decimal(19, 8) NOT NULL,
  `volume` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `tv_chart_2hours_base_coin_id_trade_coin_id_interval_unique`(`base_coin_id` ASC, `trade_coin_id` ASC, `interval` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tv_chart_2hours
-- ----------------------------

-- ----------------------------
-- Table structure for tv_chart_30mins
-- ----------------------------
DROP TABLE IF EXISTS `tv_chart_30mins`;
CREATE TABLE `tv_chart_30mins`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `interval` int UNSIGNED NOT NULL,
  `base_coin_id` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `trade_coin_id` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `open` decimal(19, 8) NOT NULL,
  `close` decimal(19, 8) NOT NULL,
  `high` decimal(19, 8) NOT NULL,
  `low` decimal(19, 8) NOT NULL,
  `volume` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `tv_chart_30mins_base_coin_id_trade_coin_id_interval_unique`(`base_coin_id` ASC, `trade_coin_id` ASC, `interval` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tv_chart_30mins
-- ----------------------------

-- ----------------------------
-- Table structure for tv_chart_4hours
-- ----------------------------
DROP TABLE IF EXISTS `tv_chart_4hours`;
CREATE TABLE `tv_chart_4hours`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `interval` int UNSIGNED NOT NULL,
  `base_coin_id` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `trade_coin_id` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `open` decimal(19, 8) NOT NULL,
  `close` decimal(19, 8) NOT NULL,
  `high` decimal(19, 8) NOT NULL,
  `low` decimal(19, 8) NOT NULL,
  `volume` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `tv_chart_4hours_base_coin_id_trade_coin_id_interval_unique`(`base_coin_id` ASC, `trade_coin_id` ASC, `interval` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tv_chart_4hours
-- ----------------------------

-- ----------------------------
-- Table structure for tv_chart_5mins
-- ----------------------------
DROP TABLE IF EXISTS `tv_chart_5mins`;
CREATE TABLE `tv_chart_5mins`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `interval` int UNSIGNED NOT NULL,
  `base_coin_id` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `trade_coin_id` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `open` decimal(19, 8) NOT NULL,
  `close` decimal(19, 8) NOT NULL,
  `high` decimal(19, 8) NOT NULL,
  `low` decimal(19, 8) NOT NULL,
  `volume` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `tv_chart_5mins_base_coin_id_trade_coin_id_interval_unique`(`base_coin_id` ASC, `trade_coin_id` ASC, `interval` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tv_chart_5mins
-- ----------------------------

-- ----------------------------
-- Table structure for user_api_white_lists
-- ----------------------------
DROP TABLE IF EXISTS `user_api_white_lists`;
CREATE TABLE `user_api_white_lists`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `ip_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `trade_access` tinyint NOT NULL DEFAULT 1,
  `withdrawal_access` tinyint NOT NULL DEFAULT 1,
  `number_of_request` bigint UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_api_white_lists
-- ----------------------------

-- ----------------------------
-- Table structure for user_banks
-- ----------------------------
DROP TABLE IF EXISTS `user_banks`;
CREATE TABLE `user_banks`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `account_holder_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `account_holder_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bank_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bank_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `country` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `swift_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `iban` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_banks
-- ----------------------------

-- ----------------------------
-- Table structure for user_navbars
-- ----------------------------
DROP TABLE IF EXISTS `user_navbars`;
CREATE TABLE `user_navbars`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sub` tinyint(1) NOT NULL DEFAULT 0,
  `main_id` int UNSIGNED NULL DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_navbars
-- ----------------------------

-- ----------------------------
-- Table structure for user_secret_keys
-- ----------------------------
DROP TABLE IF EXISTS `user_secret_keys`;
CREATE TABLE `user_secret_keys`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `secret_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date NOT NULL,
  `expire_date` date NULL DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `number_of_request` bigint UNSIGNED NOT NULL DEFAULT 0,
  `target_request` bigint UNSIGNED NOT NULL DEFAULT 0,
  `trade_access` tinyint NOT NULL DEFAULT 1,
  `withdrawal_access` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_secret_keys_secret_key_unique`(`secret_key` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_secret_keys
-- ----------------------------

-- ----------------------------
-- Table structure for user_settings
-- ----------------------------
DROP TABLE IF EXISTS `user_settings`;
CREATE TABLE `user_settings`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `slug` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_settings_user_id_foreign`(`user_id` ASC) USING BTREE,
  CONSTRAINT `user_settings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_settings
-- ----------------------------

-- ----------------------------
-- Table structure for user_verification_codes
-- ----------------------------
DROP TABLE IF EXISTS `user_verification_codes`;
CREATE TABLE `user_verification_codes`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `code` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT 0,
  `type` tinyint NOT NULL DEFAULT 1,
  `expired_at` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 77 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_verification_codes
-- ----------------------------
INSERT INTO `user_verification_codes` VALUES (1, 3, '547848', 0, 1, '2024-08-22 00:00:00', '2024-08-07 08:39:04', '2024-08-07 08:39:04');
INSERT INTO `user_verification_codes` VALUES (2, 7, '222392', 0, 1, '2024-08-23 00:00:00', '2024-08-08 01:26:39', '2024-08-08 01:26:39');
INSERT INTO `user_verification_codes` VALUES (3, 8, '227493', 0, 1, '2024-08-23 00:00:00', '2024-08-08 01:33:12', '2024-08-08 01:33:12');
INSERT INTO `user_verification_codes` VALUES (4, 9, '768548', 0, 1, '2024-08-23 00:00:00', '2024-08-08 02:00:24', '2024-08-08 02:00:24');
INSERT INTO `user_verification_codes` VALUES (5, 10, '697475', 0, 1, '2024-08-23 00:00:00', '2024-08-08 02:05:44', '2024-08-08 02:05:44');
INSERT INTO `user_verification_codes` VALUES (6, 11, '185795', 0, 1, '2024-08-23 00:00:00', '2024-08-08 03:15:02', '2024-08-08 03:15:02');
INSERT INTO `user_verification_codes` VALUES (7, 12, '386859', 0, 1, '2024-08-23 00:00:00', '2024-08-08 03:50:51', '2024-08-08 03:50:51');
INSERT INTO `user_verification_codes` VALUES (8, 13, '134865', 0, 1, '2024-08-23 00:00:00', '2024-08-08 03:57:34', '2024-08-08 03:57:34');
INSERT INTO `user_verification_codes` VALUES (9, 14, '912991', 0, 1, '2024-08-23 00:00:00', '2024-08-08 03:58:30', '2024-08-08 03:58:30');
INSERT INTO `user_verification_codes` VALUES (10, 15, '727683', 0, 1, '2024-08-23 00:00:00', '2024-08-08 04:01:21', '2024-08-08 04:01:21');
INSERT INTO `user_verification_codes` VALUES (11, 16, '827275', 0, 1, '2024-08-23 00:00:00', '2024-08-08 04:04:46', '2024-08-08 04:04:46');
INSERT INTO `user_verification_codes` VALUES (12, 17, '433212', 0, 1, '2024-08-23 00:00:00', '2024-08-08 04:05:06', '2024-08-08 04:05:06');
INSERT INTO `user_verification_codes` VALUES (13, 18, '781918', 0, 1, '2024-08-23 00:00:00', '2024-08-08 04:25:51', '2024-08-08 04:25:51');
INSERT INTO `user_verification_codes` VALUES (14, 4, '366527', 0, 1, '2024-08-23 00:00:00', '2024-08-08 04:29:13', '2024-08-08 04:29:13');
INSERT INTO `user_verification_codes` VALUES (15, 5, '923245', 0, 1, '2024-08-23 00:00:00', '2024-08-08 04:31:54', '2024-08-08 04:31:54');
INSERT INTO `user_verification_codes` VALUES (75, 65, '136223', 0, 1, '2024-08-23 00:00:00', '2024-08-08 10:50:40', '2024-08-08 10:50:40');
INSERT INTO `user_verification_codes` VALUES (76, 66, '225145', 0, 1, '2024-08-23 00:00:00', '2024-08-08 14:33:21', '2024-08-08 14:33:21');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `first_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `reset_code` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `role` int NOT NULL DEFAULT 2,
  `status` int NOT NULL DEFAULT 1,
  `api_access_allow_user` tinyint NOT NULL DEFAULT 0,
  `phone` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone_verified` tinyint NOT NULL DEFAULT 0,
  `country` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `gender` tinyint NOT NULL DEFAULT 1,
  `birth_date` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `g2f_enabled` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `google2fa_secret` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `is_verified` tinyint NOT NULL DEFAULT 0,
  `password` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `language` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'en',
  `device_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `device_type` tinyint NOT NULL DEFAULT 1,
  `push_notification_status` tinyint NOT NULL DEFAULT 1,
  `email_notification_status` tinyint NOT NULL DEFAULT 1,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email` ASC) USING BTREE,
  UNIQUE INDEX `users_reset_code_unique`(`reset_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 67 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, NULL, 'Mr.', 'Admin', 'admin@email.com', NULL, 1, 1, 0, NULL, 0, NULL, 1, NULL, NULL, '0', NULL, 1, '$2y$12$5cR2DHHr4iTVSF/htpLYguL8rfAsHB99jcHH3ed/GtGFo/V/r7nKy', 'en', NULL, 1, 1, 1, NULL, '2022-08-16 09:46:21', '2024-08-07 04:39:47');
INSERT INTO `users` VALUES (2, 'User', 'Mr', 'User', 'user@email.com', NULL, 2, 1, 0, '123456789', 0, NULL, 1, NULL, NULL, '0', NULL, 1, '$2y$10$Au3f26Dn0sqS7t83PBr61.lgOwjCXbGkJYuEhZluL1YucCnoFQ8UC', 'en', NULL, 1, 1, 1, NULL, '2022-08-16 09:46:21', '2024-08-07 09:57:37');
INSERT INTO `users` VALUES (3, NULL, 'Mr', 'SuperAdmin', 'mars@gmail.com', NULL, 2, 1, 0, '123456789', 0, NULL, 1, NULL, NULL, '0', NULL, 1, '$2y$12$2H5bR8TgZPetrVU9g7FgNeMeg/P2eqMgMZEbTg0OMDmRnceMsso0u', 'en', NULL, 1, 1, 1, NULL, '2024-08-07 08:39:04', '2024-08-07 09:55:13');
INSERT INTO `users` VALUES (4, NULL, 'Mr', 'Kunz', 'kunzf13@gmail.com_deleted_66b44a357f7b4', NULL, 2, 7, 0, NULL, 0, NULL, 1, NULL, NULL, '0', NULL, 0, '$2y$12$93WAwEfZUq0hlcxE1NvKi.4Fs.OLg4KTXliZp0JUHXprJrfAwbReC', 'en', NULL, 1, 1, 1, NULL, '2024-08-08 04:29:13', '2024-08-08 04:31:49');
INSERT INTO `users` VALUES (5, NULL, 'Mr', 'Kunz', 'kunzf13@gmail.com_deleted_66b46402e8004', NULL, 2, 7, 0, NULL, 0, NULL, 1, NULL, NULL, '0', NULL, 0, '$2y$12$32L63v.7FZRjFUxVYG3xMeV3jkFeb684OwEzhZdmKQfiDHpBDG7Sy', 'en', NULL, 1, 1, 1, NULL, '2024-08-08 04:31:54', '2024-08-08 06:21:54');
INSERT INTO `users` VALUES (65, NULL, 'Mr', 'Kunz', 'kunzf13@gmail.com', NULL, 2, 1, 0, NULL, 0, NULL, 1, NULL, NULL, '0', NULL, 0, '$2y$12$.6aOodRWrNb5qw6egTGZ3eBLgjd8f6ghbMvEocFY5iyB2CHWd/bva', 'en', NULL, 1, 1, 1, NULL, '2024-08-08 10:50:40', '2024-08-08 10:50:40');
INSERT INTO `users` VALUES (66, NULL, 'Demo', 'User', 'fasdf@sdfsdf.com', NULL, 2, 1, 0, NULL, 0, NULL, 1, NULL, NULL, '0', NULL, 0, '$2y$12$cLyJZ2rQ3DTp5QgBK1SD1eQklR7qR5CCsYP/sxRq9RJQ.KFAoc44a', 'en', NULL, 1, 1, 1, NULL, '2024-08-08 14:33:21', '2024-08-08 14:33:21');

-- ----------------------------
-- Table structure for verification_details
-- ----------------------------
DROP TABLE IF EXISTS `verification_details`;
CREATE TABLE `verification_details`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `field_name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT 0,
  `photo` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `verification_details_user_id_foreign`(`user_id` ASC) USING BTREE,
  CONSTRAINT `verification_details_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of verification_details
-- ----------------------------

-- ----------------------------
-- Table structure for wallet_address_histories
-- ----------------------------
DROP TABLE IF EXISTS `wallet_address_histories`;
CREATE TABLE `wallet_address_histories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `wallet_id` bigint NOT NULL,
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `coin_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BTC',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wallet_address_histories
-- ----------------------------

-- ----------------------------
-- Table structure for wallet_co_users
-- ----------------------------
DROP TABLE IF EXISTS `wallet_co_users`;
CREATE TABLE `wallet_co_users`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `wallet_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wallet_co_users
-- ----------------------------

-- ----------------------------
-- Table structure for wallet_networks
-- ----------------------------
DROP TABLE IF EXISTS `wallet_networks`;
CREATE TABLE `wallet_networks`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `wallet_id` bigint UNSIGNED NOT NULL,
  `coin_id` bigint UNSIGNED NOT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `network_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `wallet_networks_wallet_id_network_type_unique`(`wallet_id` ASC, `network_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wallet_networks
-- ----------------------------

-- ----------------------------
-- Table structure for wallet_swap_histories
-- ----------------------------
DROP TABLE IF EXISTS `wallet_swap_histories`;
CREATE TABLE `wallet_swap_histories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `from_wallet_id` bigint NOT NULL,
  `to_wallet_id` bigint NOT NULL,
  `from_coin_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `to_coin_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `requested_amount` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `converted_amount` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `rate` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `status` tinyint NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `wallet_swap_histories_user_id_foreign`(`user_id` ASC) USING BTREE,
  CONSTRAINT `wallet_swap_histories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wallet_swap_histories
-- ----------------------------

-- ----------------------------
-- Table structure for wallets
-- ----------------------------
DROP TABLE IF EXISTS `wallets`;
CREATE TABLE `wallets`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `name` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `coin_id` bigint NOT NULL,
  `key` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `type` tinyint NOT NULL DEFAULT 1,
  `coin_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint NOT NULL DEFAULT 1,
  `is_primary` tinyint NOT NULL DEFAULT 0,
  `balance` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `wallets_user_id_foreign`(`user_id` ASC) USING BTREE,
  CONSTRAINT `wallets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 133 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wallets
-- ----------------------------
INSERT INTO `wallets` VALUES (1, 1, 'BTC Wallet', 1, NULL, 1, 'BTC', 1, 0, 0.000000000000000000, '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `wallets` VALUES (2, 1, 'USDT Wallet', 2, NULL, 1, 'USDT', 1, 0, 0.000000000000000000, '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `wallets` VALUES (3, 2, 'BTC Wallet', 1, NULL, 1, 'BTC', 1, 0, 0.000000000000000000, '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `wallets` VALUES (4, 2, 'USDT Wallet', 2, NULL, 1, 'USDT', 1, 0, 0.000000000000000000, '2022-08-16 09:46:22', '2022-08-16 09:46:22');
INSERT INTO `wallets` VALUES (5, 3, 'BTC Wallet', 1, NULL, 1, 'BTC', 1, 0, 0.000000000000000000, '2024-08-07 08:39:04', '2024-08-07 08:39:04');
INSERT INTO `wallets` VALUES (6, 3, 'USDT Wallet', 2, NULL, 1, 'USDT', 1, 0, 0.000000000000000000, '2024-08-07 08:39:04', '2024-08-07 08:39:04');
INSERT INTO `wallets` VALUES (7, 4, 'BTC Wallet', 1, NULL, 1, 'BTC', 1, 0, 0.000000000000000000, '2024-08-08 04:29:13', '2024-08-08 04:29:13');
INSERT INTO `wallets` VALUES (8, 4, 'USDT Wallet', 2, NULL, 1, 'USDT', 1, 0, 0.000000000000000000, '2024-08-08 04:29:13', '2024-08-08 04:29:13');
INSERT INTO `wallets` VALUES (9, 5, 'BTC Wallet', 1, NULL, 1, 'BTC', 1, 0, 0.000000000000000000, '2024-08-08 04:31:54', '2024-08-08 04:31:54');
INSERT INTO `wallets` VALUES (10, 5, 'USDT Wallet', 2, NULL, 1, 'USDT', 1, 0, 0.000000000000000000, '2024-08-08 04:31:54', '2024-08-08 04:31:54');
INSERT INTO `wallets` VALUES (129, 65, 'BTC Wallet', 1, NULL, 1, 'BTC', 1, 0, 0.000000000000000000, '2024-08-08 10:50:40', '2024-08-08 10:50:40');
INSERT INTO `wallets` VALUES (130, 65, 'USDT Wallet', 2, NULL, 1, 'USDT', 1, 0, 0.000000000000000000, '2024-08-08 10:50:40', '2024-08-08 10:50:40');
INSERT INTO `wallets` VALUES (131, 66, 'BTC Wallet', 1, NULL, 1, 'BTC', 1, 0, 0.000000000000000000, '2024-08-08 14:33:21', '2024-08-08 14:33:21');
INSERT INTO `wallets` VALUES (132, 66, 'USDT Wallet', 2, NULL, 1, 'USDT', 1, 0, 0.000000000000000000, '2024-08-08 14:33:21', '2024-08-08 14:33:21');

-- ----------------------------
-- Table structure for websockets_statistics_entries
-- ----------------------------
DROP TABLE IF EXISTS `websockets_statistics_entries`;
CREATE TABLE `websockets_statistics_entries`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `app_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `peak_connection_count` int NOT NULL,
  `websocket_message_count` int NOT NULL,
  `api_message_count` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of websockets_statistics_entries
-- ----------------------------

-- ----------------------------
-- Table structure for withdraw_histories
-- ----------------------------
DROP TABLE IF EXISTS `withdraw_histories`;
CREATE TABLE `withdraw_histories`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `wallet_id` bigint UNSIGNED NOT NULL,
  `amount` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `btc` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `doller` decimal(19, 8) NOT NULL DEFAULT 0.00000000,
  `address_type` tinyint NOT NULL,
  `address` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_hash` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `coin_type` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'BTC',
  `receiver_wallet_id` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `confirmations` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `fees` decimal(29, 18) NOT NULL DEFAULT 0.000000000000000000,
  `status` tinyint NOT NULL DEFAULT 0,
  `message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `withdraw_histories_wallet_id_foreign`(`wallet_id` ASC) USING BTREE,
  CONSTRAINT `withdraw_histories_wallet_id_foreign` FOREIGN KEY (`wallet_id`) REFERENCES `wallets` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of withdraw_histories
-- ----------------------------

-- ----------------------------
-- Triggers structure for table buys
-- ----------------------------
DROP TRIGGER IF EXISTS `buy_process_not_big_than_amount`;
delimiter ;;
CREATE TRIGGER `buy_process_not_big_than_amount` BEFORE UPDATE ON `buys` FOR EACH ROW BEGIN
                                declare msg varchar(128);
                                if new.processed > OLD.amount then
                                  set msg = concat('Process Not Bigger than Amount');
                                  signal sqlstate '45000' set message_text = msg;
                                end if;
                              END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table sells
-- ----------------------------
DROP TRIGGER IF EXISTS `sell_process_not_big_than_amount`;
delimiter ;;
CREATE TRIGGER `sell_process_not_big_than_amount` BEFORE UPDATE ON `sells` FOR EACH ROW BEGIN
                                declare msg varchar(128);
                                if new.processed > OLD.amount then
                                  set msg = concat('Process Not Bigger than Amount');
                                  signal sqlstate '45000' set message_text = msg;
                                end if;
                              END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table transactions
-- ----------------------------
DROP TRIGGER IF EXISTS `update_transaction_last_price`;
delimiter ;;
CREATE TRIGGER `update_transaction_last_price` BEFORE INSERT ON `transactions` FOR EACH ROW BEGIN
              SET NEW.last_price = (select price from transactions 
              where 
                base_coin_id = NEW.base_coin_id 
                  and 
                trade_coin_id = NEW.trade_coin_id
                order by created_at desc limit 1 );
            END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
