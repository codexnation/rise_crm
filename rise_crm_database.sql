-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 21, 2024 at 08:32 PM
-- Server version: 10.5.25-MariaDB
-- PHP Version: 8.1.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ryanjobs_faffingaround_crm`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_activity_logs`
--

CREATE TABLE `tbl_activity_logs` (
  `id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `action` enum('created','updated','deleted','bitbucket_notification_received','github_notification_received') NOT NULL,
  `log_type` varchar(30) NOT NULL,
  `log_type_title` mediumtext NOT NULL,
  `log_type_id` int(11) NOT NULL DEFAULT 0,
  `changes` mediumtext DEFAULT NULL,
  `log_for` varchar(30) NOT NULL DEFAULT '0',
  `log_for_id` int(11) NOT NULL DEFAULT 0,
  `log_for2` varchar(30) DEFAULT NULL,
  `log_for_id2` int(11) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_announcements`
--

CREATE TABLE `tbl_announcements` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` mediumtext NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `created_by` int(11) NOT NULL,
  `share_with` mediumtext DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `files` text NOT NULL,
  `read_by` mediumtext DEFAULT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_article_helpful_status`
--

CREATE TABLE `tbl_article_helpful_status` (
  `id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `status` enum('yes','no') NOT NULL,
  `created_by` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_attendance`
--

CREATE TABLE `tbl_attendance` (
  `id` int(11) NOT NULL,
  `status` enum('incomplete','pending','approved','rejected','deleted') NOT NULL DEFAULT 'incomplete',
  `user_id` int(11) NOT NULL,
  `in_time` datetime NOT NULL,
  `out_time` datetime DEFAULT NULL,
  `checked_by` int(11) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `checked_at` datetime DEFAULT NULL,
  `reject_reason` text DEFAULT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_checklist_groups`
--

CREATE TABLE `tbl_checklist_groups` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `checklists` mediumtext NOT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_checklist_items`
--

CREATE TABLE `tbl_checklist_items` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `is_checked` int(11) NOT NULL DEFAULT 0,
  `task_id` int(11) NOT NULL DEFAULT 0,
  `sort` int(11) NOT NULL DEFAULT 0,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_checklist_template`
--

CREATE TABLE `tbl_checklist_template` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_ci_sessions`
--

CREATE TABLE `tbl_ci_sessions` (
  `id` varchar(128) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `data` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_ci_sessions`
--

INSERT INTO `tbl_ci_sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('ci_session:o2mg5dtbkkb9jb4lifn8ufe6ev7seg2k', '106.215.22.208', '2024-06-21 18:16:20', 0x5f5f63695f6c6173745f726567656e65726174657c693a313731383939333737393b5f63695f70726576696f75735f75726c7c733a34333a22687474703a2f2f66616666696e6761726f756e642e636f2e756b2f696e6465782e7068702f7369676e696e223b),
('ci_session:rnb2dqkrervm6ambv6j8l8mliaeteri1', '106.215.22.208', '2024-06-21 18:17:11', 0x5f5f63695f6c6173745f726567656e65726174657c693a313731383939333830323b5f63695f70726576696f75735f75726c7c733a35353a2268747470733a2f2f66616666696e6761726f756e642e636f2e756b2f696e6465782e7068702f64617368626f6172642f696e6465782f31223b757365725f69647c733a313a2231223b);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_clients`
--

CREATE TABLE `tbl_clients` (
  `id` int(11) NOT NULL,
  `company_name` varchar(150) NOT NULL,
  `type` enum('organization','person') NOT NULL DEFAULT 'organization',
  `address` text DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `zip` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `created_date` date NOT NULL,
  `website` text DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `currency_symbol` varchar(20) DEFAULT NULL,
  `starred_by` mediumtext NOT NULL,
  `group_ids` text NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `is_lead` tinyint(1) NOT NULL DEFAULT 0,
  `lead_status_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `lead_source_id` int(11) NOT NULL,
  `last_lead_status` text NOT NULL,
  `client_migration_date` date NOT NULL,
  `vat_number` text DEFAULT NULL,
  `gst_number` text DEFAULT NULL,
  `stripe_customer_id` text NOT NULL,
  `stripe_card_ending_digit` int(11) NOT NULL,
  `currency` varchar(3) DEFAULT NULL,
  `disable_online_payment` tinyint(1) NOT NULL DEFAULT 0,
  `labels` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_client_groups`
--

CREATE TABLE `tbl_client_groups` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_company`
--

CREATE TABLE `tbl_company` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `address` text NOT NULL,
  `phone` text NOT NULL,
  `email` text NOT NULL,
  `website` text NOT NULL,
  `vat_number` text NOT NULL,
  `gst_number` text NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `logo` mediumtext NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_company`
--

INSERT INTO `tbl_company` (`id`, `name`, `address`, `phone`, `email`, `website`, `vat_number`, `gst_number`, `is_default`, `logo`, `deleted`) VALUES
(1, 'Company Name', '', '', '', '', '', '', 1, '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_contracts`
--

CREATE TABLE `tbl_contracts` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `client_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `contract_date` date NOT NULL,
  `valid_until` date NOT NULL,
  `note` mediumtext DEFAULT NULL,
  `last_email_sent_date` date DEFAULT NULL,
  `status` enum('draft','sent','accepted','declined') NOT NULL DEFAULT 'draft',
  `tax_id` int(11) NOT NULL DEFAULT 0,
  `tax_id2` int(11) NOT NULL DEFAULT 0,
  `discount_type` enum('before_tax','after_tax') NOT NULL,
  `discount_amount` double NOT NULL,
  `discount_amount_type` enum('percentage','fixed_amount') NOT NULL,
  `content` mediumtext NOT NULL,
  `public_key` varchar(10) NOT NULL,
  `accepted_by` int(11) NOT NULL DEFAULT 0,
  `staff_signed_by` int(11) NOT NULL DEFAULT 0,
  `meta_data` text NOT NULL,
  `files` mediumtext NOT NULL,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_contract_items`
--

CREATE TABLE `tbl_contract_items` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text DEFAULT NULL,
  `quantity` double NOT NULL,
  `unit_type` varchar(20) NOT NULL DEFAULT '',
  `rate` double NOT NULL,
  `total` double NOT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `contract_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_contract_templates`
--

CREATE TABLE `tbl_contract_templates` (
  `id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `template` mediumtext DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_contract_templates`
--

INSERT INTO `tbl_contract_templates` (`id`, `title`, `template`, `deleted`) VALUES
(1, 'Template 3.6', '<table style=\"background-color:#3D3D3D; color:#fff;\" class=\"table\"><tbody><tr><td style=\"text-align: center; \"><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><div style=\"\"><span style=\"font-size: 40px;\"><b>{CONTRACT_TITLE}</b></span><br></div><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p></td></tr></tbody></table><p style=\"text-align: justify; \"><br></p><p style=\"text-align: justify; \">This contract states the terms and conditions that shall govern the contractual agreement between {COMPANY_NAME} (the Service Provider) and {CONTRACT_TO_COMPANY_NAME} (the Client) who agrees to be bound by the terms of the contract.</p>\n\n<table style=\"margin-top: 0; margin-bottom: 10px;\">\n    <tbody>\n        <tr>\n            <td style=\"padding: 0;\">\n                <div style=\"margin-top: 20px\">\n                    <div style=\"text-align: center\">\n                        <div style=\"font-size: 30px\">{CONTRACT_ID}</div>\n\n<table style=\"margin-top: 10px;\"><tbody><tr><td></td><td></td><td></td><td><div style=\"border-bottom: 5px solid #ff9800;\"></div></td><td></td><td></td><td></td></tr></tbody></table>\n                    </div>\n                </div>\n            </td>\n        </tr>\n    </tbody>\n</table>\n\n<div>\n Contract Date: {CONTRACT_DATE}<br>\n Expiry Date: {CONTRACT_EXPIRY_DATE}\n</div>\n<table style=\"width: 100%; padding-top: 30px; margin-top: 0;\">\n<tbody>\n<tr>\n<td style=\"width: 50%;padding-left:0; padding-right: 10px;\"><p>Client</p>{CONTRACT_TO_INFO}</td>\n<td style=\"width: 50%; padding-left: 10px;\"><p>Service Provider</p>{COMPANY_INFO}</td>\n</tr>\n</tbody>\n</table>\n\n<br pagebreak=\"true\">\n<table style=\"margin-top: 0; margin-bottom: 10px;\">\n    <tbody>\n        <tr>\n            <td style=\"padding: 0;\">\n                <div style=\"margin-top: 20px\">\n                    <div style=\"text-align: center\">\n                        <div style=\"font-size: 30px\">Service Details</div>\n                        \n<table style=\"margin-top: 10px;\"><tbody><tr><td></td><td></td><td></td><td><div style=\"border-bottom: 5px solid #ff9800;\"></div></td><td></td><td></td><td></td></tr></tbody></table>\n                    </div>\n                </div>\n            </td>\n        </tr>\n    </tbody>\n</table>\n<p style=\"text-align: justify; \">The specific scope, timeline, and any additional requirements related to the services shall be detailed in a separate document or statement of work, which shall form an integral part of this contract.</p><p><br></p>\n\n{CONTRACT_ITEMS}<p></p><p><br></p><p><br></p><p></p>\n\n<br pagebreak=\"true\">\n\n<table style=\"margin-top: 0; margin-bottom: 10px;\">\n    <tbody>\n        <tr>\n            <td style=\"padding: 0;\">\n                <div style=\"margin-top: 20px\">\n                    <div style=\"text-align: center\">\n                        <div style=\"font-size: 30px\">1. Service Policy</div>\n                        \n<table style=\"margin-top: 10px;\"><tbody><tr><td></td><td></td><td></td><td><div style=\"border-bottom: 5px solid #ff9800;\"></div></td><td></td><td></td><td></td></tr></tbody></table>\n                    </div>\n                </div>\n            </td>\n        </tr>\n    </tbody>\n</table>\n<p style=\"text-align: justify; \">The Service Policy outlines the terms and conditions governing the provision of services by Service Provider to the Client. It encompasses guidelines regarding service delivery, quality standards, support mechanisms, and dispute resolution procedures. The Service Provider is committed to upholding the highest level of professionalism, responsiveness, and customer satisfaction in delivering the agreed upon services.</p><p style=\"text-align: justify; \"><br></p><p style=\"text-align: justify; \">Any deviations from the Service Policy shall be communicated promptly and resolved in a timely manner to ensure seamless collaboration and adherence to the mutual objectives outlined in the contract.</p><p style=\"text-align: justify; \"><br></p>\n<br pagebreak=\"true\">\n\n<table style=\"margin-top: 0; margin-bottom: 10px;\">\n    <tbody>\n        <tr>\n            <td style=\"padding: 0;\">\n                <div style=\"margin-top: 20px\">\n                    <div style=\"text-align: center\">\n                        <div style=\"font-size: 30px\">2. Delivery</div>\n                        \n<table style=\"margin-top: 10px;\"><tbody><tr><td></td><td></td><td></td><td><div style=\"border-bottom: 5px solid #ff9800;\"></div></td><td></td><td></td><td></td></tr></tbody></table>\n                    </div>\n                </div>\n            </td>\n        </tr>\n    </tbody>\n</table>\n<p style=\"text-align: justify; \">The Service Provider will commence delivery of services upon receipt of a signed contract and any necessary initial payments as specified. Delivery timelines and milestones will be outlined in the project schedule or statement of work provided to the Client. The Service Provider will make reasonable efforts to meet agreed-upon deadlines and milestones, keeping the Client informed of any delays or changes to the delivery schedule. Delivery methods may vary depending on the nature of the services and may include in-person meetings, electronic communication, or physical shipment of goods.</p><p style=\"text-align: justify; \"><br></p><p style=\"text-align: justify; \">Upon completion of the services, the Client will be provided with deliverables as outlined in the project scope or statement of work, with any necessary documentation or training materials included as specified.</p><p style=\"text-align: justify; \"><br></p>\n<br pagebreak=\"true\">\n\n<table style=\"margin-top: 0; margin-bottom: 10px;\">\n    <tbody>\n        <tr>\n            <td style=\"padding: 0;\">\n                <div style=\"margin-top: 20px\">\n                    <div style=\"text-align: center\">\n                        <div style=\"font-size: 30px\">3. Intellectual property rights</div>\n                        \n<table style=\"margin-top: 10px;\"><tbody><tr><td></td><td></td><td></td><td><div style=\"border-bottom: 5px solid #ff9800;\"></div></td><td></td><td></td><td></td></tr></tbody></table>\n                    </div>\n                </div>\n            </td>\n        </tr>\n    </tbody>\n</table>\n<p style=\"text-align: justify; \">All intellectual property rights, including but not limited to copyrights, patents, trademarks, and trade secrets, associated with the services provided under this contract shall remain the exclusive property of the originating party unless otherwise agreed upon in writing. The Service Provider retains ownership of any proprietary methodologies, technologies, or materials utilized in delivering the services, and the Client agrees not to reproduce, distribute, or disclose such intellectual property without prior written consent.</p><p style=\"text-align: justify; \"><br></p><p style=\"text-align: justify; \">Any intellectual property created or developed during the course of providing the services shall be jointly owned by both parties unless otherwise specified in a separate agreement. Any use or exploitation of intellectual property rights beyond the scope of this contract requires the express written consent of the owning party.</p><p style=\"text-align: justify; \"><br></p>\n<br pagebreak=\"true\">\n\n<table style=\"margin-top: 0; margin-bottom: 10px;\">\n    <tbody>\n        <tr>\n            <td style=\"padding: 0;\">\n                <div style=\"margin-top: 20px\">\n                    <div style=\"text-align: center\">\n                        <div style=\"font-size: 30px\">4. Confidentiality</div>\n                        \n<table style=\"margin-top: 10px;\"><tbody><tr><td></td><td></td><td></td><td><div style=\"border-bottom: 5px solid #ff9800;\"></div></td><td></td><td></td><td></td></tr></tbody></table>\n                    </div>\n                </div>\n            </td>\n        </tr>\n    </tbody>\n</table>\n<p style=\"text-align: justify; \">Both parties agree to maintain strict confidentiality regarding any proprietary or sensitive information disclosed during the course of this contract. This includes but is not limited to trade secrets, business strategies, financial information, and client data. The Service Provider shall take all necessary precautions to prevent unauthorized access or disclosure of confidential information and shall only share such information with authorized personnel directly involved in fulfilling the obligations of this contract.</p><p style=\"text-align: justify; \"><br></p><p style=\"text-align: justify; \">The Client agrees not to disclose any confidential information obtained from the Service Provider to any third parties without prior written consent. This confidentiality obligation shall survive the termination of this contract and continue indefinitely thereafter.</p><p style=\"text-align: justify; \"><br></p>\n<br pagebreak=\"true\">\n\n<table style=\"margin-top: 0; margin-bottom: 10px;\">\n    <tbody>\n        <tr>\n            <td style=\"padding: 0;\">\n                <div style=\"margin-top: 20px\">\n                    <div style=\"text-align: center\">\n                        <div style=\"font-size: 30px\">5. Support</div>\n                        \n<table style=\"margin-top: 10px;\"><tbody><tr><td></td><td></td><td></td><td><div style=\"border-bottom: 5px solid #ff9800;\"></div></td><td></td><td></td><td></td></tr></tbody></table>\n                    </div>\n                </div>\n            </td>\n        </tr>\n    </tbody>\n</table>\n<p style=\"text-align: justify; \">The Service Provider agrees to provide reasonable support and assistance to the Client during the term of this contract. Support may include but is not limited to troubleshooting, technical assistance, and guidance related to the services provided. The Service Provider will make commercially reasonable efforts to respond promptly to inquiries and requests for support from the Client, within the parameters specified in the service level agreement (SLA) or support agreement. Support will be provided during normal business hours unless otherwise agreed upon. Any additional support beyond the scope outlined in this contract may be subject to additional fees or terms as mutually agreed upon by both parties.<br></p><p style=\"text-align: justify; \"><br></p><p style=\"text-align: justify; \">{CONTRACT_NOTE}</p>\n\n', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_custom_fields`
--

CREATE TABLE `tbl_custom_fields` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `title_language_key` text NOT NULL,
  `placeholder_language_key` text NOT NULL,
  `show_in_embedded_form` tinyint(4) NOT NULL DEFAULT 0,
  `placeholder` text NOT NULL,
  `example_variable_name` text DEFAULT NULL,
  `options` mediumtext NOT NULL,
  `field_type` varchar(50) NOT NULL,
  `related_to` varchar(50) NOT NULL,
  `sort` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `add_filter` tinyint(1) NOT NULL DEFAULT 0,
  `show_in_table` tinyint(1) NOT NULL DEFAULT 0,
  `show_in_invoice` tinyint(1) NOT NULL DEFAULT 0,
  `show_in_estimate` tinyint(1) NOT NULL DEFAULT 0,
  `show_in_contract` tinyint(1) NOT NULL DEFAULT 0,
  `show_in_order` tinyint(1) NOT NULL DEFAULT 0,
  `show_in_proposal` tinyint(1) NOT NULL DEFAULT 0,
  `visible_to_admins_only` tinyint(1) NOT NULL DEFAULT 0,
  `hide_from_clients` tinyint(1) NOT NULL DEFAULT 0,
  `disable_editing_by_clients` tinyint(1) NOT NULL DEFAULT 0,
  `show_on_kanban_card` tinyint(1) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `show_in_subscription` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_custom_field_values`
--

CREATE TABLE `tbl_custom_field_values` (
  `id` int(11) NOT NULL,
  `related_to_type` varchar(50) NOT NULL,
  `related_to_id` int(11) NOT NULL,
  `custom_field_id` int(11) NOT NULL,
  `value` longtext NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_custom_widgets`
--

CREATE TABLE `tbl_custom_widgets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` text DEFAULT NULL,
  `content` mediumtext DEFAULT NULL,
  `show_title` tinyint(1) NOT NULL DEFAULT 0,
  `show_border` tinyint(1) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_dashboards`
--

CREATE TABLE `tbl_dashboards` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` text DEFAULT NULL,
  `data` text DEFAULT NULL,
  `color` varchar(15) NOT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_email_templates`
--

CREATE TABLE `tbl_email_templates` (
  `id` int(11) NOT NULL,
  `template_name` varchar(50) NOT NULL,
  `email_subject` text NOT NULL,
  `default_message` mediumtext NOT NULL,
  `custom_message` mediumtext DEFAULT NULL,
  `template_type` enum('default','custom') NOT NULL DEFAULT 'default',
  `language` varchar(50) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_email_templates`
--

INSERT INTO `tbl_email_templates` (`id`, `template_name`, `email_subject`, `default_message`, `custom_message`, `template_type`, `language`, `deleted`) VALUES
(1, 'login_info', 'Login details', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"><div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\">  <h1>Login Details</h1></div><div style=\"padding: 20px; background-color: rgb(255, 255, 255);\">            <p style=\"color: rgb(85, 85, 85); font-size: 14px;\"> Hello {USER_FIRST_NAME} {USER_LAST_NAME},<br><br>An account has been created for you.</p>            <p style=\"color: rgb(85, 85, 85); font-size: 14px;\"> Please use the following info to login your dashboard:</p>            <hr>            <p style=\"color: rgb(85, 85, 85); font-size: 14px;\">Dashboard URL:&nbsp;<a href=\"{DASHBOARD_URL}\" target=\"_blank\">{DASHBOARD_URL}</a></p>            <p style=\"color: rgb(85, 85, 85); font-size: 14px;\"></p>            <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">Email: {USER_LOGIN_EMAIL}</span><br></p>            <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">Password:&nbsp;{USER_LOGIN_PASSWORD}</span></p>            <p style=\"color: rgb(85, 85, 85);\"><br></p>            <p style=\"color: rgb(85, 85, 85); font-size: 14px;\">{SIGNATURE}</p>        </div>    </div></div>', '', 'default', '', 0),
(2, 'reset_password', 'Reset password', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"><div style=\"max-width:640px; margin:0 auto; \"><div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>Reset Password</h1>\n </div>\n <div style=\"padding: 20px; background-color: rgb(255, 255, 255); color:#555;\">                    <p style=\"font-size: 14px;\"> Hello {ACCOUNT_HOLDER_NAME},<br><br>A password reset request has been created for your account.&nbsp;</p>\n                    <p style=\"font-size: 14px;\"> To initiate the password reset process, please click on the following link:</p>\n                    <p style=\"font-size: 14px;\"><a href=\"{RESET_PASSWORD_URL}\" target=\"_blank\">Reset Password</a></p>\n                    <p style=\"font-size: 14px;\"></p>\n                    <p style=\"\"><span style=\"font-size: 14px; line-height: 20px;\"><br></span></p>\n<p style=\"\"><span style=\"font-size: 14px; line-height: 20px;\">If you\'ve received this mail in error, it\'s likely that another user entered your email address by mistake while trying to reset a password.</span><br></p>\n<p style=\"\"><span style=\"font-size: 14px; line-height: 20px;\">If you didn\'t initiate the request, you don\'t need to take any further action and can safely disregard this email.</span><br></p>\n<p style=\"font-size: 14px;\"><br></p>\n<p style=\"font-size: 14px;\">{SIGNATURE}</p>\n                </div>\n            </div>\n        </div>', '', 'default', '', 0),
(3, 'team_member_invitation', 'You are invited', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"><div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>Account Invitation</h1>   </div>  <div style=\"padding: 20px; background-color: rgb(255, 255, 255);\">            <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">Hello,</span><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><span style=\"font-weight: bold;\"><br></span></span></p>            <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><span style=\"font-weight: bold;\">{INVITATION_SENT_BY}</span> has sent you an invitation to join with a team.</span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><br></span></p>            <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{INVITATION_URL}\" target=\"_blank\">Accept this Invitation</a></span></p>            <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><br></span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">If you don not want to accept this invitation, simply ignore this email.</span><br><br></p>            <p style=\"color: rgb(85, 85, 85); font-size: 14px;\">{SIGNATURE}</p>        </div>    </div></div>', '', 'default', '', 0),
(4, 'send_invoice', 'New invoice', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>INVOICE #{INVOICE_ID}</h1></div> <div style=\"padding: 20px; background-color: rgb(255, 255, 255);\">  <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">Hello {CONTACT_FIRST_NAME},</span><br></p><p style=\"\"><span style=\"font-size: 14px; line-height: 20px;\">Thank you for your business cooperation.</span><br></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">Your invoice for the project {PROJECT_TITLE} has been generated and is attached here.</span></p><p style=\"\"><br></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{INVOICE_URL}\" target=\"_blank\">Show Invoice</a></span></p><p style=\"\"><span style=\"font-size: 14px; line-height: 20px;\"><br></span></p><p style=\"\"><span style=\"font-size: 14px; line-height: 20px;\">Invoice balance due is {BALANCE_DUE}</span><br></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">Please pay this invoice within {DUE_DATE}.&nbsp;</span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><br></span></p><p style=\"color: rgb(85, 85, 85); font-size: 14px;\">{SIGNATURE}</p>  </div> </div></div>', '', 'default', '', 0),
(5, 'signature', 'Signature', 'Powered By: <a href=\"http://fairsketch.com/\" target=\"_blank\">fairsketch </a>', '', 'default', '', 0),
(6, 'client_contact_invitation', 'You are invited', '<div style=\"background-color: #eeeeef; padding: 50px 0; \">    <div style=\"max-width:640px; margin:0 auto; \">  <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>Account Invitation</h1> </div> <div style=\"padding: 20px; background-color: rgb(255, 255, 255);\">            <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">Hello,</span><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><span style=\"font-weight: bold;\"><br></span></span></p>            <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><span style=\"font-weight: bold;\">{INVITATION_SENT_BY}</span> has sent you an invitation to a client portal.</span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><br></span></p>            <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{INVITATION_URL}\" target=\"_blank\">Accept this Invitation</a></span></p>            <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><br></span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">If you don not want to accept this invitation, simply ignore this email.</span><br><br></p>            <p style=\"color: rgb(85, 85, 85); font-size: 14px;\">{SIGNATURE}</p>        </div>    </div></div>', '', 'default', '', 0),
(7, 'ticket_created', 'Ticket  #{TICKET_ID} - {TICKET_TITLE}', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>Ticket #{TICKET_ID} Opened</h1></div><div style=\"padding: 20px; background-color: rgb(255, 255, 255);\"><p style=\"\"><span style=\"line-height: 18.5714px; font-weight: bold;\">Title: {TICKET_TITLE}</span><span style=\"line-height: 18.5714px;\"><br></span></p><p style=\"\"><span style=\"line-height: 18.5714px;\">{TICKET_CONTENT}</span><br></p> <p style=\"\"><br></p> <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{TICKET_URL}\" target=\"_blank\">Show Ticket</a></span></p> <p style=\"\"><br></p><p style=\"\">Regards,</p><p style=\"\"><span style=\"line-height: 18.5714px;\">{USER_NAME}</span><br></p>   </div>  </div> </div>', '', 'default', '', 0),
(8, 'ticket_commented', 'Ticket  #{TICKET_ID} - {TICKET_TITLE}', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>Ticket #{TICKET_ID} Replies</h1></div><div style=\"padding: 20px; background-color: rgb(255, 255, 255);\"><p style=\"\"><span style=\"line-height: 18.5714px; font-weight: bold;\">Title: {TICKET_TITLE}</span><span style=\"line-height: 18.5714px;\"><br></span></p><p style=\"\"><span style=\"line-height: 18.5714px;\">{TICKET_CONTENT}</span></p><p style=\"\"><span style=\"line-height: 18.5714px;\"><br></span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{TICKET_URL}\" target=\"_blank\">Show Ticket</a></span></p></div></div></div>', '', 'default', '', 0),
(9, 'ticket_closed', 'Ticket  #{TICKET_ID} - {TICKET_TITLE}', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>Ticket #{TICKET_ID}</h1></div><div style=\"padding: 20px; background-color: rgb(255, 255, 255);\"><p style=\"\"><span style=\"line-height: 18.5714px;\">The Ticket #{TICKET_ID} has been closed by&nbsp;</span><span style=\"line-height: 18.5714px;\">{USER_NAME}</span></p> <p style=\"\"><br></p> <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{TICKET_URL}\" target=\"_blank\">Show Ticket</a></span></p>   </div>  </div> </div>', '', 'default', '', 0),
(10, 'ticket_reopened', 'Ticket  #{TICKET_ID} - {TICKET_TITLE}', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>Ticket #{TICKET_ID}</h1></div><div style=\"padding: 20px; background-color: rgb(255, 255, 255);\"><p style=\"\"><span style=\"line-height: 18.5714px;\">The Ticket #{TICKET_ID} has been reopened by&nbsp;</span><span style=\"line-height: 18.5714px;\">{USER_NAME}</span></p><p style=\"\"><br></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{TICKET_URL}\" target=\"_blank\">Show Ticket</a></span></p>  </div> </div></div>', '', 'default', '', 0),
(11, 'general_notification', '{EVENT_TITLE}', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>{APP_TITLE}</h1></div><div style=\"padding: 20px; background-color: rgb(255, 255, 255);\"><p style=\"\"><span style=\"line-height: 18.5714px;\">{EVENT_TITLE}</span></p><p style=\"\"><span style=\"line-height: 18.5714px;\">{EVENT_DETAILS}</span></p><p style=\"\"><span style=\"line-height: 18.5714px;\"><br></span></p><p style=\"\"><span style=\"line-height: 18.5714px;\"></span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{NOTIFICATION_URL}\" target=\"_blank\">View Details</a></span></p>  </div> </div></div>', '', 'default', '', 0),
(12, 'invoice_payment_confirmation', 'Payment received', '<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #EEEEEE;border-top: 0;border-bottom: 0;\">\r\n <tbody><tr>\r\n <td align=\"center\" valign=\"top\" style=\"padding-top: 30px;padding-right: 10px;padding-bottom: 30px;padding-left: 10px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\">\r\n <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"600\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\">\r\n <tbody><tr>\r\n <td align=\"center\" valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\">\r\n <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #FFFFFF;\">\r\n                                        <tbody><tr>\r\n                                                <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\">\r\n                                                    <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\">\r\n                                                        <tbody>\r\n                                                            <tr>\r\n                                                                <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\">\r\n                                                                    <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"background-color: #33333e; max-width: 100%;min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\" width=\"100%\">\r\n                                                                        <tbody><tr>\r\n                                                                                <td valign=\"top\" style=\"padding-top: 40px;padding-right: 18px;padding-bottom: 40px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\">\r\n                                                                                    <h2 style=\"display: block;margin: 0;padding: 0;font-family: Arial;font-size: 30px;font-style: normal;font-weight: bold;line-height: 100%;letter-spacing: -1px;text-align: center;color: #ffffff !important;\">Payment Confirmation</h2>\r\n                                                                                </td>\r\n                                                                            </tr>\r\n                                                                        </tbody>\r\n                                                                    </table>\r\n                                                                </td>\r\n                                                            </tr>\r\n                                                        </tbody>\r\n                                                    </table>\r\n                                                    <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\">\r\n                                                        <tbody>\r\n                                                            <tr>\r\n                                                                <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\">\r\n\r\n                                                                    <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"max-width: 100%;min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\" width=\"100%\">\r\n                                                                        <tbody><tr>\r\n                                                                                <td valign=\"top\" style=\"padding-top: 20px;padding-right: 18px;padding-bottom: 0;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\">\r\n                                                                                    Hello,<br>\r\n                                                                                    We have received your payment of {PAYMENT_AMOUNT} for {INVOICE_ID} <br>\r\n                                                                                    Thank you for your business cooperation.\r\n                                                                                </td>\r\n                                                                            </tr>\r\n                                                                            <tr>\r\n                                                                                <td valign=\"top\" style=\"padding-top: 10px;padding-right: 18px;padding-bottom: 10px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\">\r\n                                                                                    <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\">\r\n                                                                                        <tbody>\r\n                                                                                            <tr>\r\n                                                                                                <td style=\"padding-top: 15px;padding-right: 0x;padding-bottom: 15px;padding-left: 0px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\">\r\n                                                                                                    <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate !important;border-radius: 2px;background-color: #00b393;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\">\r\n                                                                                                        <tbody>\r\n                                                                                                            <tr>\r\n                                                                                                                <td align=\"center\" valign=\"middle\" style=\"font-family: Arial;font-size: 16px;padding: 10px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\">\r\n                                                                                                                    <a href=\"{INVOICE_URL}\" target=\"_blank\" style=\"font-weight: bold;letter-spacing: normal;line-height: 100%;text-align: center;text-decoration: none;color: #FFFFFF;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;display: block;\">View Invoice</a>\r\n                                                                                                                </td>\r\n                                                                                                            </tr>\r\n                                                                                                        </tbody>\r\n                                                                                                    </table>\r\n                                                                                                </td>\r\n                                                                                            </tr>\r\n                                                                                        </tbody>\r\n                                                                                    </table>\r\n                                                                                </td>\r\n                                                                            </tr>\r\n                                                                            <tr>\r\n                                                                                <td valign=\"top\" style=\"padding-top: 0px;padding-right: 18px;padding-bottom: 10px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"> \r\n                                                                                    \r\n                                                                                </td>\r\n                                                                            </tr>\r\n                                                                            <tr>\r\n                                                                                <td valign=\"top\" style=\"padding-top: 0px;padding-right: 18px;padding-bottom: 20px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"> \r\n  {SIGNATURE}\r\n  </td>\r\n </tr>\r\n </tbody>\r\n  </table>\r\n  </td>\r\n  </tr>\r\n  </tbody>\r\n </table>\r\n  </td>\r\n </tr>\r\n  </tbody>\r\n  </table>\r\n  </td>\r\n </tr>\r\n </tbody>\r\n </table>\r\n </td>\r\n </tr>\r\n </tbody>\r\n  </table>', '', 'default', '', 0),
(13, 'message_received', '{SUBJECT}', '<meta content=\"text/html; charset=utf-8\" http-equiv=\"Content-Type\"> <meta content=\"width=device-width, initial-scale=1.0\" name=\"viewport\"> <style type=\"text/css\"> #message-container p {margin: 10px 0;} #message-container h1, #message-container h2, #message-container h3, #message-container h4, #message-container h5, #message-container h6 { padding:10px; margin:0; } #message-container table td {border-collapse: collapse;} #message-container table { border-collapse:collapse; mso-table-lspace:0pt; mso-table-rspace:0pt; } #message-container a span{padding:10px 15px !important;} </style> <table id=\"message-container\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"background:#eee; margin:0; padding:0; width:100% !important; line-height: 100% !important; -webkit-text-size-adjust:100%; -ms-text-size-adjust:100%; margin:0; padding:0; font-family:Helvetica,Arial,sans-serif; color: #555;\"> <tbody> <tr> <td valign=\"top\"> <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"> <tbody> <tr> <td height=\"50\" width=\"600\">&nbsp;</td> </tr> <tr> <td style=\"background-color:#33333e; padding:25px 15px 30px 15px; font-weight:bold; \" width=\"600\"><h2 style=\"color:#fff; text-align:center;\">{USER_NAME} sent you a message</h2></td> </tr> <tr> <td bgcolor=\"whitesmoke\" style=\"background:#fff; font-family:Helvetica,Arial,sans-serif\" valign=\"top\" width=\"600\"> <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"> <tbody> <tr> <td height=\"10\" width=\"560\">&nbsp;</td> </tr> <tr> <td width=\"560\"><p><span style=\"background-color: transparent;\">{MESSAGE_CONTENT}</span></p> <p style=\"display:inline-block; padding: 10px 15px; background-color: #00b393;\"><a href=\"{MESSAGE_URL}\" style=\"text-decoration: none; color:#fff;\" target=\"_blank\">Reply Message</a></p> </td> </tr> <tr> <td height=\"10\" width=\"560\">&nbsp;</td> </tr> </tbody> </table> </td> </tr> <tr> <td height=\"60\" width=\"600\">&nbsp;</td> </tr> </tbody> </table> </td> </tr> </tbody> </table>', '', 'default', '', 0),
(14, 'invoice_due_reminder_before_due_date', 'Invoice due reminder', '<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #EEEEEE;border-top: 0;border-bottom: 0;\"> <tbody><tr> <td align=\"center\" valign=\"top\" style=\"padding-top: 30px;padding-right: 10px;padding-bottom: 30px;padding-left: 10px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"600\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody><tr> <td align=\"center\" valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #FFFFFF;\"> <tbody><tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody> <tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"background-color: #33333e; max-width: 100%;min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\" width=\"100%\"> <tbody><tr> <td valign=\"top\" style=\"padding-top: 40px;padding-right: 18px;padding-bottom: 40px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"> <h2 style=\"display: block;margin: 0;padding: 0;font-family: Arial;font-size: 30px;font-style: normal;font-weight: bold;line-height: 100%;letter-spacing: -1px;text-align: center;color: #ffffff !important;\">Invoice Due Reminder</h2></td></tr></tbody></table></td></tr></tbody></table> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody> <tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"max-width: 100%;min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\" width=\"100%\"> <tbody><tr> <td valign=\"top\" style=\"padding-top: 20px;padding-right: 18px;padding-bottom: 0;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"><p> Hello,<br>We would like to remind you that invoice {INVOICE_ID} is due on {DUE_DATE}. Please pay the invoice within due date.&nbsp;</p><p></p></td></tr><tr><td valign=\"top\" style=\"padding-top: 10px;padding-right: 18px;padding-bottom: 10px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"><p>If you have already submitted the payment, please ignore this email.</p><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"><tbody><tr><td style=\"padding-top: 15px;padding-right: 0x;padding-bottom: 15px;padding-left: 0px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate !important;border-radius: 2px;background-color: #00b393;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"><tbody><tr><td align=\"center\" valign=\"middle\" style=\"font-family: Arial;font-size: 16px;padding: 10px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"><a href=\"{INVOICE_URL}\" target=\"_blank\" style=\"font-weight: bold;letter-spacing: normal;line-height: 100%;text-align: center;text-decoration: none;color: #FFFFFF;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;display: block;\">View Invoice</a> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> <p></p></td> </tr> <tr> <td valign=\"top\" style=\"padding-top: 0px;padding-right: 18px;padding-bottom: 20px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"> {SIGNATURE} </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table>', '', 'default', '', 0),
(15, 'invoice_overdue_reminder', 'Invoice overdue reminder', '<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #EEEEEE;border-top: 0;border-bottom: 0;\"> <tbody><tr> <td align=\"center\" valign=\"top\" style=\"padding-top: 30px;padding-right: 10px;padding-bottom: 30px;padding-left: 10px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"600\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody><tr> <td align=\"center\" valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #FFFFFF;\"> <tbody><tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody> <tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"background-color: #33333e; max-width: 100%;min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\" width=\"100%\"> <tbody><tr> <td valign=\"top\" style=\"padding-top: 40px;padding-right: 18px;padding-bottom: 40px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"> <h2 style=\"display: block;margin: 0;padding: 0;font-family: Arial;font-size: 30px;font-style: normal;font-weight: bold;line-height: 100%;letter-spacing: -1px;text-align: center;color: #ffffff !important;\">Invoice Overdue Reminder</h2></td></tr></tbody></table></td></tr></tbody></table> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody> <tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"max-width: 100%;min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\" width=\"100%\"> <tbody><tr> <td valign=\"top\" style=\"padding-top: 20px;padding-right: 18px;padding-bottom: 0;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"><p> Hello,<br>We would like to remind you that you have an unpaid invoice {INVOICE_ID}. We kindly request you to pay the invoice as soon as possible.&nbsp;</p><p></p></td></tr><tr><td valign=\"top\" style=\"padding-top: 10px;padding-right: 18px;padding-bottom: 10px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"><p>If you have already submitted the payment, please ignore this email.</p><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"><tbody><tr><td style=\"padding-top: 15px;padding-right: 0x;padding-bottom: 15px;padding-left: 0px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate !important;border-radius: 2px;background-color: #00b393;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"><tbody><tr><td align=\"center\" valign=\"middle\" style=\"font-family: Arial;font-size: 16px;padding: 10px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"><a href=\"{INVOICE_URL}\" target=\"_blank\" style=\"font-weight: bold;letter-spacing: normal;line-height: 100%;text-align: center;text-decoration: none;color: #FFFFFF;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;display: block;\">View Invoice</a> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> <p></p></td> </tr> <tr> <td valign=\"top\" style=\"padding-top: 0px;padding-right: 18px;padding-bottom: 20px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"> {SIGNATURE} </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table>', '', 'default', '', 0),
(16, 'recurring_invoice_creation_reminder', 'Recurring invoice creation reminder', '<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #EEEEEE;border-top: 0;border-bottom: 0;\"> <tbody><tr> <td align=\"center\" valign=\"top\" style=\"padding-top: 30px;padding-right: 10px;padding-bottom: 30px;padding-left: 10px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"600\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody><tr> <td align=\"center\" valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #FFFFFF;\"> <tbody><tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody> <tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"background-color: #33333e; max-width: 100%;min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\" width=\"100%\"> <tbody><tr> <td valign=\"top\" style=\"padding-top: 40px;padding-right: 18px;padding-bottom: 40px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"> <h2 style=\"display: block;margin: 0;padding: 0;font-family: Arial;font-size: 30px;font-style: normal;font-weight: bold;line-height: 100%;letter-spacing: -1px;text-align: center;color: #ffffff !important;\">Invoice Cration Reminder</h2></td></tr></tbody></table></td></tr></tbody></table> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody> <tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"max-width: 100%;min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\" width=\"100%\"> <tbody><tr> <td valign=\"top\" style=\"padding-top: 20px;padding-right: 18px;padding-bottom: 0;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"><p> Hello,<br>We would like to remind you that a recurring invoice will be created on {NEXT_RECURRING_DATE}.</p><p></p></td></tr><tr><td valign=\"top\" style=\"padding-top: 10px;padding-right: 18px;padding-bottom: 10px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%; text-size-adjust: 100%;\"><tbody><tr><td style=\"padding-top: 15px; padding-bottom: 15px; text-size-adjust: 100%;\"><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate !important;border-radius: 2px;background-color: #00b393;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"><tbody><tr><td align=\"center\" valign=\"middle\" style=\"font-size: 16px; padding: 10px; text-size-adjust: 100%;\"><a href=\"{INVOICE_URL}\" target=\"_blank\" style=\"font-weight: bold; line-height: 100%; color: rgb(255, 255, 255); text-size-adjust: 100%; display: block;\">View Invoice</a></td></tr></tbody></table></td></tr></tbody></table> <p></p></td> </tr> <tr> <td valign=\"top\" style=\"padding-top: 0px;padding-right: 18px;padding-bottom: 20px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"> {SIGNATURE} </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table>', '', 'default', '', 0),
(17, 'project_task_deadline_reminder', 'Project task deadline reminder', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>{APP_TITLE}</h1></div> <div style=\"padding: 20px; background-color: rgb(255, 255, 255);\">  <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">Hello,</span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">This is to remind you that there are some tasks which deadline is {DEADLINE}.</span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">{TASKS_LIST}</span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><br></span></p><p style=\"color: rgb(85, 85, 85); font-size: 14px;\">{SIGNATURE}</p>  </div> </div></div>', '', 'default', '', 0),
(18, 'estimate_sent', 'New estimate', '<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #EEEEEE;border-top: 0;border-bottom: 0;\"> <tbody><tr> <td align=\"center\" valign=\"top\" style=\"padding-top: 30px;padding-right: 10px;padding-bottom: 30px;padding-left: 10px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"600\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody><tr> <td align=\"center\" valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #FFFFFF;\"> <tbody><tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody> <tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"background-color: #33333e; max-width: 100%;min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\" width=\"100%\"> <tbody><tr> <td valign=\"top\" style=\"padding: 40px 18px; text-size-adjust: 100%; word-break: break-word; line-height: 150%; text-align: left;\"> <h2 style=\"display: block; margin: 0px; padding: 0px; line-height: 100%; text-align: center;\"><font color=\"#ffffff\" face=\"Arial\"><span style=\"letter-spacing: -1px;\"><b>ESTIMATE #{ESTIMATE_ID}</b></span></font><br></h2></td></tr></tbody></table></td></tr></tbody></table> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody> <tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"max-width: 100%;min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\" width=\"100%\"> <tbody><tr> <td valign=\"top\" style=\"padding-top: 20px;padding-right: 18px;padding-bottom: 0;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"><p> Hello {CONTACT_FIRST_NAME},<br></p><p>Here is the estimate. Please check the attachment.</p><p></p></td></tr><tr><td valign=\"top\" style=\"padding-top: 10px;padding-right: 18px;padding-bottom: 10px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%; text-size-adjust: 100%;\"><tbody><tr><td style=\"padding-top: 15px; padding-bottom: 15px; text-size-adjust: 100%;\"><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate !important;border-radius: 2px;background-color: #00b393;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"><tbody><tr><td align=\"center\" valign=\"middle\" style=\"font-size: 16px; padding: 10px; text-size-adjust: 100%;\"><a href=\"{ESTIMATE_URL}\" target=\"_blank\" style=\"font-weight: bold; line-height: 100%; color: rgb(255, 255, 255); text-size-adjust: 100%; display: block;\">Show Estimate</a></td></tr></tbody></table></td></tr></tbody></table> <p></p></td> </tr> <tr> <td valign=\"top\" style=\"padding-top: 0px;padding-right: 18px;padding-bottom: 20px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"> {SIGNATURE} </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table>', '', 'default', '', 0);
INSERT INTO `tbl_email_templates` (`id`, `template_name`, `email_subject`, `default_message`, `custom_message`, `template_type`, `language`, `deleted`) VALUES
(19, 'estimate_request_received', 'Estimate request received', '<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #EEEEEE;border-top: 0;border-bottom: 0;\"> <tbody><tr> <td align=\"center\" valign=\"top\" style=\"padding-top: 30px;padding-right: 10px;padding-bottom: 30px;padding-left: 10px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"600\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody><tr> <td align=\"center\" valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #FFFFFF;\"> <tbody><tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody> <tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"background-color: #33333e; max-width: 100%;min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\" width=\"100%\"> <tbody><tr> <td valign=\"top\" style=\"padding: 40px 18px; text-size-adjust: 100%; word-break: break-word; line-height: 150%; text-align: left;\"> <h2 style=\"display: block; margin: 0px; padding: 0px; line-height: 100%; text-align: center;\"><font color=\"#ffffff\" face=\"Arial\"><span style=\"letter-spacing: -1px;\"><b>ESTIMATE REQUEST #{ESTIMATE_REQUEST_ID}</b></span></font><br></h2></td></tr></tbody></table></td></tr></tbody></table> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody> <tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"max-width: 100%;min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\" width=\"100%\"> <tbody><tr> <td valign=\"top\" style=\"padding: 20px 18px 0px; text-size-adjust: 100%; word-break: break-word; line-height: 150%; text-align: left;\"><p style=\"color: rgb(96, 96, 96); font-family: Arial; font-size: 15px;\"><span style=\"background-color: transparent;\">A new estimate request has been received from {CONTACT_FIRST_NAME}.</span><br></p><p style=\"color: rgb(96, 96, 96); font-family: Arial; font-size: 15px;\"></p></td></tr><tr><td valign=\"top\" style=\"padding-top: 10px;padding-right: 18px;padding-bottom: 10px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%; text-size-adjust: 100%;\"><tbody><tr><td style=\"padding-top: 15px; padding-bottom: 15px; text-size-adjust: 100%;\"><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate !important;border-radius: 2px;background-color: #00b393;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"><tbody><tr><td align=\"center\" valign=\"middle\" style=\"font-size: 16px; padding: 10px; text-size-adjust: 100%;\"><a href=\"{ESTIMATE_REQUEST_URL}\" target=\"_blank\" style=\"font-weight: bold; line-height: 100%; color: rgb(255, 255, 255); text-size-adjust: 100%; display: block;\">Show Estimate Request</a></td></tr></tbody></table></td></tr></tbody></table> <p></p></td> </tr> <tr> <td valign=\"top\" style=\"padding-top: 0px;padding-right: 18px;padding-bottom: 20px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"> {SIGNATURE} </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table>', '', 'default', '', 0),
(20, 'estimate_rejected', 'Estimate rejected', '<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #EEEEEE;border-top: 0;border-bottom: 0;\"> <tbody><tr> <td align=\"center\" valign=\"top\" style=\"padding-top: 30px;padding-right: 10px;padding-bottom: 30px;padding-left: 10px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"600\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody><tr> <td align=\"center\" valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #FFFFFF;\"> <tbody><tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody> <tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"background-color: #33333e; max-width: 100%;min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\" width=\"100%\"> <tbody><tr> <td valign=\"top\" style=\"padding: 40px 18px; text-size-adjust: 100%; word-break: break-word; line-height: 150%; text-align: left;\"> <h2 style=\"display: block; margin: 0px; padding: 0px; line-height: 100%; text-align: center;\"><font color=\"#ffffff\" face=\"Arial\"><span style=\"letter-spacing: -1px;\"><b>ESTIMATE #{ESTIMATE_ID}</b></span></font><br></h2></td></tr></tbody></table></td></tr></tbody></table> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody> <tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"max-width: 100%;min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\" width=\"100%\"> <tbody><tr> <td valign=\"top\" style=\"padding: 20px 18px 0px; text-size-adjust: 100%; word-break: break-word; line-height: 150%; text-align: left;\"><p style=\"\"><font color=\"#606060\" face=\"Arial\"><span style=\"font-size: 15px;\">The estimate #{ESTIMATE_ID} has been rejected.</span></font><br></p><p style=\"color: rgb(96, 96, 96); font-family: Arial; font-size: 15px;\"></p></td></tr><tr><td valign=\"top\" style=\"padding-top: 10px;padding-right: 18px;padding-bottom: 10px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%; text-size-adjust: 100%;\"><tbody><tr><td style=\"padding-top: 15px; padding-bottom: 15px; text-size-adjust: 100%;\"><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate !important;border-radius: 2px;background-color: #00b393;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"><tbody><tr><td align=\"center\" valign=\"middle\" style=\"font-size: 16px; padding: 10px; text-size-adjust: 100%;\"><a href=\"{ESTIMATE_URL}\" target=\"_blank\" style=\"font-weight: bold; line-height: 100%; color: rgb(255, 255, 255); text-size-adjust: 100%; display: block;\">Show Estimate</a></td></tr></tbody></table></td></tr></tbody></table> <p></p></td> </tr> <tr> <td valign=\"top\" style=\"padding-top: 0px;padding-right: 18px;padding-bottom: 20px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"> {SIGNATURE} </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table>', '', 'default', '', 0),
(21, 'estimate_accepted', 'Estimate accepted', '<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #EEEEEE;border-top: 0;border-bottom: 0;\"> <tbody><tr> <td align=\"center\" valign=\"top\" style=\"padding-top: 30px;padding-right: 10px;padding-bottom: 30px;padding-left: 10px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"600\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody><tr> <td align=\"center\" valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #FFFFFF;\"> <tbody><tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody> <tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"background-color: #33333e; max-width: 100%;min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\" width=\"100%\"> <tbody><tr> <td valign=\"top\" style=\"padding: 40px 18px; text-size-adjust: 100%; word-break: break-word; line-height: 150%; text-align: left;\"> <h2 style=\"display: block; margin: 0px; padding: 0px; line-height: 100%; text-align: center;\"><font color=\"#ffffff\" face=\"Arial\"><span style=\"letter-spacing: -1px;\"><b>ESTIMATE #{ESTIMATE_ID}</b></span></font><br></h2></td></tr></tbody></table></td></tr></tbody></table> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody> <tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"max-width: 100%;min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\" width=\"100%\"> <tbody><tr> <td valign=\"top\" style=\"padding: 20px 18px 0px; text-size-adjust: 100%; word-break: break-word; line-height: 150%; text-align: left;\"><p style=\"\"><font color=\"#606060\" face=\"Arial\"><span style=\"font-size: 15px;\">The estimate #{ESTIMATE_ID} has been accepted.</span></font><br></p><p style=\"color: rgb(96, 96, 96); font-family: Arial; font-size: 15px;\"></p></td></tr><tr><td valign=\"top\" style=\"padding-top: 10px;padding-right: 18px;padding-bottom: 10px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%; text-size-adjust: 100%;\"><tbody><tr><td style=\"padding-top: 15px; padding-bottom: 15px; text-size-adjust: 100%;\"><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate !important;border-radius: 2px;background-color: #00b393;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"><tbody><tr><td align=\"center\" valign=\"middle\" style=\"font-size: 16px; padding: 10px; text-size-adjust: 100%;\"><a href=\"{ESTIMATE_URL}\" target=\"_blank\" style=\"font-weight: bold; line-height: 100%; color: rgb(255, 255, 255); text-size-adjust: 100%; display: block;\">Show Estimate</a></td></tr></tbody></table></td></tr></tbody></table> <p></p></td> </tr> <tr> <td valign=\"top\" style=\"padding-top: 0px;padding-right: 18px;padding-bottom: 20px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"> {SIGNATURE} </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table>', '', 'default', '', 0),
(22, 'new_client_greetings', 'Welcome!', '<div style=\"background-color: #eeeeef; padding: 50px 0; \">    <div style=\"max-width:640px; margin:0 auto; \">  <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>Welcome to {COMPANY_NAME}</h1> </div> <div style=\"padding: 20px; background-color: rgb(255, 255, 255);\">            <p><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">Hello {CONTACT_FIRST_NAME},</span></p><p><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">Thank you for creating your account. </span></p><p><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">We are happy to see you here.<br></span></p><hr><p style=\"color: rgb(85, 85, 85); font-size: 14px;\">Dashboard URL:&nbsp;<a href=\"{DASHBOARD_URL}\" target=\"_blank\">{DASHBOARD_URL}</a></p><p style=\"color: rgb(85, 85, 85); font-size: 14px;\"></p><p><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">Email: {CONTACT_LOGIN_EMAIL}</span><br></p><p><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">Password:&nbsp;{CONTACT_LOGIN_PASSWORD}</span></p><p style=\"color: rgb(85, 85, 85);\"><br></p><p style=\"color: rgb(85, 85, 85); font-size: 14px;\">{SIGNATURE}</p>        </div>    </div></div>', '', 'default', '', 0),
(23, 'verify_email', 'Please verify your email', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"><div style=\"max-width:640px; margin:0 auto; \"><div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>Account verification</h1></div><div style=\"padding: 20px; background-color: rgb(255, 255, 255); color:#555;\"><p style=\"font-size: 14px;\">To initiate the signup process, please click on the following link:<br></p><p style=\"font-size: 14px;\"><br></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{VERIFY_EMAIL_URL}\" target=\"_blank\">Verify Email</a></span></p>  <p style=\"font-size: 14px;\"><br></p><p style=\"\"><span style=\"font-size: 14px;\">If you did not initiate the request, you do not need to take any further action and can safely disregard this email.</span></p><p style=\"\"><span style=\"font-size: 14px;\"><br></span></p><p style=\"font-size: 14px;\">{SIGNATURE}</p></div></div></div>', '', 'default', '', 0),
(24, 'new_order_received', 'New order received', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>ORDER #{ORDER_ID}</h1></div> <div style=\"padding: 20px; background-color: rgb(255, 255, 255);\">  <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px;\">A new order has been received from&nbsp;</span><span style=\"color: rgb(85, 85, 85); font-size: 14px;\">{CONTACT_FIRST_NAME} and is attached here.</span><br></p><p style=\"\"><br></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{ORDER_URL}\" target=\"_blank\">Show Order</a></span></p><p style=\"\"><br></p>  </div> </div></div>', '', 'default', '', 0),
(25, 'order_status_updated', 'Order status updated', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>ORDER #{ORDER_ID}</h1></div> <div style=\"padding: 20px; background-color: rgb(255, 255, 255);\">  <p><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">Hello {CONTACT_FIRST_NAME},</span><br></p><p><span style=\"font-size: 14px; line-height: 20px;\">Thank you for your business cooperation.</span><br></p><p><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">Your order&nbsp;</span><font color=\"#555555\"><span style=\"font-size: 14px;\">has been updated&nbsp;</span></font><span style=\"color: rgb(85, 85, 85); font-size: 14px;\">and is attached here.</span></p><p style=\"\"><br></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{ORDER_URL}\" target=\"_blank\">Show Order</a></span></p><p style=\"\"><br></p>  </div> </div></div>', '', 'default', '', 0),
(26, 'proposal_sent', 'Proposal sent', '<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #EEEEEE;border-top: 0;border-bottom: 0;\"> <tbody><tr> <td align=\"center\" valign=\"top\" style=\"padding-top: 30px;padding-right: 10px;padding-bottom: 30px;padding-left: 10px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"600\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody><tr> <td align=\"center\" valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #FFFFFF;\"> <tbody><tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody> <tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"background-color: #33333e; max-width: 100%;min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\" width=\"100%\"> <tbody><tr> <td valign=\"top\" style=\"padding: 40px 18px; text-size-adjust: 100%; word-break: break-word; line-height: 150%; text-align: left;\"> <h2 style=\"display: block; margin: 0px; padding: 0px; line-height: 100%; text-align: center;\"><font color=\"#ffffff\" face=\"Arial\"><span style=\"letter-spacing: -1px;\"><b>PROPOSAL #{PROPOSAL_ID}</b></span></font><br></h2></td></tr></tbody></table></td></tr></tbody></table> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody> <tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"max-width: 100%;min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\" width=\"100%\"> <tbody><tr> <td valign=\"top\" style=\"padding-top: 20px;padding-right: 18px;padding-bottom: 0;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"><p> Hello {CONTACT_FIRST_NAME},<br></p><p>Here is a proposal for you.</p><p></p></td></tr><tr><td valign=\"top\" style=\"padding-top: 10px;padding-right: 18px;padding-bottom: 10px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%; text-size-adjust: 100%;\"><tbody><tr><td style=\"padding-top: 15px; padding-bottom: 15px; text-size-adjust: 100%;\"><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate !important;border-radius: 2px;background-color: #00b393;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"><tbody><tr><td align=\"center\" valign=\"middle\" style=\"font-size: 16px; padding: 10px; text-size-adjust: 100%;\"><a href=\"{PROPOSAL_URL}\" target=\"_blank\" style=\"font-weight: bold; line-height: 100%; color: rgb(255, 255, 255); text-size-adjust: 100%; display: block;\">Show Proposal</a></td></tr></tbody></table></td></tr></tbody></table> <p></p></td> </tr> <tr> <td valign=\"top\" style=\"padding-top: 0px;padding-right: 18px;padding-bottom: 20px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"><p> </p><p>Public URL: {PUBLIC_PROPOSAL_URL}</p><p><br></p><p>{SIGNATURE} </p></td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table>', '', 'default', '', 0),
(27, 'project_completed', 'Project completed', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>Project #{PROJECT_ID}</h1></div><div style=\"padding: 20px; background-color: rgb(255, 255, 255);\"><p style=\"\"><span style=\"line-height: 18.5714px;\">The Project #{PROJECT_ID}&nbsp;has been closed by&nbsp;</span><span style=\"line-height: 18.5714px;\">{USER_NAME}</span></p><p style=\"\"><span style=\"line-height: 18.5714px;\">Title:&nbsp;</span>{PROJECT_TITLE}</p> <p style=\"\"><br></p> <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{PROJECT_URL}\" target=\"_blank\">Show Project</a></span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><br></span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><span style=\"color: rgb(78, 94, 106); font-size: 13.5px;\">{SIGNATURE}</span><br></span></p>   </div>  </div> </div>', '', 'default', '', 0),
(28, 'proposal_accepted', 'Proposal accepted', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>PROPOSAL #{PROPOSAL_ID}</h1></div> <div style=\"padding: 20px; background-color: rgb(255, 255, 255);\">  <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px;\">The proposal #{PROPOSAL_ID} has been accepted.</span><br></p><p style=\"\"><br></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{PROPOSAL_URL}\" target=\"_blank\">Show Proposal</a></span></p><p style=\"\"><br></p>  </div> </div></div>', '', 'default', '', 0),
(29, 'proposal_rejected', 'Proposal rejected', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>PROPOSAL #{PROPOSAL_ID}</h1></div> <div style=\"padding: 20px; background-color: rgb(255, 255, 255);\">  <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px;\">The proposal #{PROPOSAL_ID} has been rejected.</span><br></p><p style=\"\"><br></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{PROPOSAL_URL}\" target=\"_blank\">Show Proposal</a></span></p><p style=\"\"><br></p>  </div> </div></div>', '', 'default', '', 0),
(30, 'estimate_commented', 'Estimate  #{ESTIMATE_ID}', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>Estimate #{ESTIMATE_ID} Replies</h1></div><div style=\"padding: 20px; background-color: rgb(255, 255, 255);\"><p style=\"\"><span style=\"line-height: 18.5714px;\">{COMMENT_CONTENT}</span></p><p style=\"\"><span style=\"line-height: 18.5714px;\"><br></span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{ESTIMATE_URL}\" target=\"_blank\">Show Estimate</a></span></p></div></div></div>', '', 'default', '', 0),
(31, 'contract_sent', 'Contract sent', '<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #EEEEEE;border-top: 0;border-bottom: 0;\"> <tbody><tr> <td align=\"center\" valign=\"top\" style=\"padding-top: 30px;padding-right: 10px;padding-bottom: 30px;padding-left: 10px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"600\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody><tr> <td align=\"center\" valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #FFFFFF;\"> <tbody><tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody> <tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"background-color: #33333e; max-width: 100%;min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\" width=\"100%\"> <tbody><tr> <td valign=\"top\" style=\"padding: 40px 18px; text-size-adjust: 100%; word-break: break-word; line-height: 150%; text-align: left;\"> <h2 style=\"display: block; margin: 0px; padding: 0px; line-height: 100%; text-align: center;\"><font color=\"#ffffff\" face=\"Arial\"><span style=\"letter-spacing: -1px;\"><b>CONTRACT #{CONTRACT_ID}</b></span></font><br></h2></td></tr></tbody></table></td></tr></tbody></table> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody> <tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"max-width: 100%;min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\" width=\"100%\"> <tbody><tr> <td valign=\"top\" style=\"padding-top: 20px;padding-right: 18px;padding-bottom: 0;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"><p> Hello {CONTACT_FIRST_NAME},<br></p><p>Here is a contract for you.</p><p></p></td></tr><tr><td valign=\"top\" style=\"padding-top: 10px;padding-right: 18px;padding-bottom: 10px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%; text-size-adjust: 100%;\"><tbody><tr><td style=\"padding-top: 15px; padding-bottom: 15px; text-size-adjust: 100%;\"><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate !important;border-radius: 2px;background-color: #00b393;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"><tbody><tr><td align=\"center\" valign=\"middle\" style=\"font-size: 16px; padding: 10px; text-size-adjust: 100%;\"><a href=\"{CONTRACT_URL}\" target=\"_blank\" style=\"font-weight: bold; line-height: 100%; color: rgb(255, 255, 255); text-size-adjust: 100%; display: block;\">Show Contract</a></td></tr></tbody></table></td></tr></tbody></table></td></tr><tr><td valign=\"top\" style=\"padding-top: 0px;padding-right: 18px;padding-bottom: 20px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"><p>Public URL: {PUBLIC_CONTRACT_URL}<br></p><p><br></p><p>{SIGNATURE}<br></p></td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table>', '', 'default', '', 0),
(32, 'contract_accepted', 'Contract accepted', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>CONTRACT #{CONTRACT_ID}</h1></div> <div style=\"padding: 20px; background-color: rgb(255, 255, 255);\">  <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px;\">The contract #{CONTRACT_ID} has been accepted.</span><br></p><p style=\"\"><br></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{CONTRACT_URL}\" target=\"_blank\">Show Contract</a></span></p><p style=\"\"><br></p>  </div> </div></div>', '', 'default', '', 0),
(33, 'contract_rejected', 'Contract rejected', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>CONTRACT #{CONTRACT_ID}</h1></div> <div style=\"padding: 20px; background-color: rgb(255, 255, 255);\">  <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px;\">The contract #{CONTRACT_ID} has been rejected.</span><br></p><p style=\"\"><br></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{CONTRACT_URL}\" target=\"_blank\">Show Contract</a></span></p><p style=\"\"><br></p>  </div> </div></div>', '', 'default', '', 0),
(34, 'invoice_manual_payment_added', 'Manual payment added', '<table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #EEEEEE;border-top: 0;border-bottom: 0;\"> <tbody><tr> <td align=\"center\" valign=\"top\" style=\"padding-top: 30px;padding-right: 10px;padding-bottom: 30px;padding-left: 10px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"600\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody><tr> <td align=\"center\" valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;background-color: #FFFFFF;\"> <tbody><tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody> <tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"background-color: #33333e; max-width: 100%;min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\" width=\"100%\"> <tbody><tr> <td valign=\"top\" style=\"padding-top: 40px;padding-right: 18px;padding-bottom: 40px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"> <h2 style=\"display: block;margin: 0;padding: 0;font-family: Arial;font-size: 30px;font-style: normal;font-weight: bold;line-height: 100%;letter-spacing: -1px;text-align: center;color: #ffffff !important;\">Payment Added</h2> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody> <tr> <td valign=\"top\" style=\"mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"max-width: 100%;min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\" width=\"100%\"> <tbody><tr> <td valign=\"top\" style=\"padding-top: 20px;padding-right: 18px;padding-bottom: 0;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"><p> Hello,</p><p>A new payment has been added to {INVOICE_ID}. </p><p>Payment amount: {PAYMENT_AMOUNT}</p></td> </tr> <tr> <td valign=\"top\" style=\"padding-top: 10px;padding-right: 18px;padding-bottom: 10px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"min-width: 100%;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody> <tr> <td style=\"padding-top: 15px;padding-right: 0x;padding-bottom: 15px;padding-left: 0px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" style=\"border-collapse: separate !important;border-radius: 2px;background-color: #00b393;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <tbody> <tr> <td align=\"center\" valign=\"middle\" style=\"font-family: Arial;font-size: 16px;padding: 10px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;\"> <a href=\"{INVOICE_URL}\" target=\"_blank\" style=\"font-weight: bold;letter-spacing: normal;line-height: 100%;text-align: center;text-decoration: none;color: #FFFFFF;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;display: block;\">View Invoice</a> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> <tr> <td valign=\"top\" style=\"padding-top: 0px;padding-right: 18px;padding-bottom: 10px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"> </td> </tr> <tr> <td valign=\"top\" style=\"padding-top: 0px;padding-right: 18px;padding-bottom: 20px;padding-left: 18px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;word-break: break-word;color: #606060;font-family: Arial;font-size: 15px;line-height: 150%;text-align: left;\"> {SIGNATURE} </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table> </td> </tr> </tbody> </table>', '', 'default', '', 0),
(35, 'subscription_request_sent', 'New subscription request', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h2>{SUBSCRIPTION_TITLE}</h2></div> <div style=\"padding: 20px; background-color: rgb(255, 255, 255);\">  <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">Hello {CONTACT_FIRST_NAME},</span><br></p><p style=\"\"><span style=\"font-size: 14px;\">You have a new subscription request. Please click here to see the subscription.</span></p><p style=\"\"><br></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{SUBSCRIPTION_URL}\" target=\"_blank\">Show Subscription</a></span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><br></span></p><p style=\"color: rgb(85, 85, 85); font-size: 14px;\">{SIGNATURE}</p>  </div> </div></div>', '', 'default', '', 0),
(36, 'announcement_created', '{ANNOUNCEMENT_TITLE}', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>Announcement: {ANNOUNCEMENT_TITLE}</h1></div><div style=\"padding: 20px; background-color: rgb(255, 255, 255);\"><p style=\"\"><span style=\"line-height: 18.5714px;\">A new announcement has been created by {USER_NAME}.</span></p><p style=\"\"><span style=\"line-height: 18.5714px;\"><br></span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{ANNOUNCEMENT_URL}\" target=\"_blank\">Show Announcement</a></span></p></div></div></div>', '', 'default', '', 0),
(37, 'task_general', '{TASK_TITLE} (Task #{TASK_ID})', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>{EVENT_TITLE}</h1></div><div style=\"padding: 20px; background-color: rgb(255, 255, 255);\"><p style=\"\"><span style=\"line-height: 18.5714px;\"><b>Task:</b> #</span><span style=\"font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">{TASK_ID} -&nbsp;</span><span style=\"font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">{TASK_TITLE}</span></p><p style=\"\"><span style=\"line-height: 18.5714px;\"><b>{CONTEXT_LABEL}:</b>&nbsp;</span>{CONTEXT_TITLE}</p> <p style=\"\"><br></p> <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{TASK_URL}\" target=\"_blank\">Show Task&nbsp;</a></span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><br></span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><span style=\"color: rgb(78, 94, 106); font-size: 13.5px;\">{SIGNATURE}</span><br></span></p>   </div>  </div> </div>', '', 'default', '', 0),
(38, 'task_assigned', '{TASK_TITLE} (Task #{TASK_ID})', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>Task assigned</h1></div><div style=\"padding: 20px; background-color: rgb(255, 255, 255);\"><p style=\"\"><span style=\"line-height: 18.5714px;\"><b>{USER_NAME}</b>  Assigned a task to <b>{ASSIGNED_TO_USER_NAME}</b></span></p><p style=\"\"><span style=\"line-height: 18.5714px;\"><b>Task:</b> #</span><span style=\"font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">{TASK_ID} -&nbsp;</span><span style=\"font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">{TASK_TITLE}</span></p><p style=\"\"><span style=\"line-height: 18.5714px;\"><b>{CONTEXT_LABEL}:</b>&nbsp;</span>{CONTEXT_TITLE}</p> <p style=\"\"><br></p> <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{TASK_URL}\" target=\"_blank\">Show Task&nbsp;</a></span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><br></span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><span style=\"color: rgb(78, 94, 106); font-size: 13.5px;\">{SIGNATURE}</span><br></span></p>   </div>  </div> </div>', '', 'default', '', 0),
(39, 'task_commented', '{TASK_TITLE} (Task #{TASK_ID})', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>Task commented</h1></div><div style=\"padding: 20px; background-color: rgb(255, 255, 255);\"><p style=\"\"><span style=\"line-height: 18.5714px;\"><b>{USER_NAME}</b>  Commented on a task.</span></p><p style=\"\"><span style=\"line-height: 18.5714px;\"><b>Task:</b> #</span><span style=\"font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">{TASK_ID} -&nbsp;</span><span style=\"font-weight: var(--bs-body-font-weight); text-align: var(--bs-body-text-align);\">{TASK_TITLE}</span></p><p style=\"\"><span style=\"line-height: 18.5714px;\"><b>{CONTEXT_LABEL}:</b>&nbsp;</span>{CONTEXT_TITLE}</p> <p style=\"\"><br></p> <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{TASK_URL}\" target=\"_blank\">Show Task&nbsp;</a></span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><br></span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><span style=\"color: rgb(78, 94, 106); font-size: 13.5px;\">{SIGNATURE}</span><br></span></p>   </div>  </div> </div>', '', 'default', '', 0),
(40, 'subscription_started', 'Started a subscription', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h2>{SUBSCRIPTION_TITLE}</h2></div> <div style=\"padding: 20px; background-color: rgb(255, 255, 255);\">  <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">Hello {CONTACT_FIRST_NAME},</span><br></p><p style=\"\"><span style=\"font-size: 14px;\">A new subscription has been started.&nbsp;</span></p><p style=\"\"><br></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{SUBSCRIPTION_URL}\" target=\"_blank\">Show Subscription</a></span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><br></span></p><p style=\"color: rgb(85, 85, 85); font-size: 14px;\">{SIGNATURE}</p>  </div> </div></div>', '', 'default', '', 0);
INSERT INTO `tbl_email_templates` (`id`, `template_name`, `email_subject`, `default_message`, `custom_message`, `template_type`, `language`, `deleted`) VALUES
(41, 'subscription_invoice_created_via_cron_job', 'New invoice generated from subscription', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>INVOICE #{INVOICE_ID}</h1></div> <div style=\"padding: 20px; background-color: rgb(255, 255, 255);\">  <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">Hello {CONTACT_FIRST_NAME},</span><br></p><p style=\"\"><span style=\"font-size: 14px; line-height: 20px;\">Thank you for your business cooperation.</span><br></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">Your invoice for the subscription {SUBSCRIPTION_TITLE} has been generated and is attached here.</span></p><p style=\"\"><br></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{INVOICE_URL}\" target=\"_blank\">Show Invoice</a></span></p><p style=\"\"><span style=\"font-size: 14px; line-height: 20px;\"><br></span></p><p style=\"\"><span style=\"font-size: 14px; line-height: 20px;\">Invoice balance due is {BALANCE_DUE}</span><br></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">Please pay this invoice within {DUE_DATE}.&nbsp;</span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><br></span></p><p style=\"color: rgb(85, 85, 85); font-size: 14px;\">{SIGNATURE}</p>  </div> </div></div>', '', 'default', '', 0),
(42, 'send_credit_note', 'New credit note', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>CREDIT NOTE #{CREDIT_NOTE_ID}</h1></div> <div style=\"padding: 20px; background-color: rgb(255, 255, 255);\">  <p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">Hello {CONTACT_FIRST_NAME},</span><br></p><p style=\"\"><span style=\"font-size: 14px; line-height: 20px;\">Your invoice {INVOICE_ID} has been credited.&nbsp;</span><br></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\">Here is the credit note.&nbsp;</span></p><p style=\"\"><br></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{CREDIT_NOTE_URL}\" target=\"_blank\">Show Credit Note</a></span></p><p style=\"\"><br></p><p style=\"color: rgb(85, 85, 85); font-size: 14px;\">{SIGNATURE}</p>  </div> </div></div>', '', 'default', '', 0),
(43, 'subscription_cancelled', 'Subscription cancelled', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h2>{SUBSCRIPTION_TITLE}</h2></div> <div style=\"padding: 20px; background-color: rgb(255, 255, 255);\">  <p style=\"\"><font color=\"#606060\" face=\"Arial\"><span style=\"font-size: 15px;\">The subscription {SUBSCRIPTION_TITLE} has been cancelled by {CANCELLED_BY}.</span></font><br></p><p style=\"\"><br></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{SUBSCRIPTION_URL}\" target=\"_blank\">Show Subscription</a></span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><br></span></p><p style=\"color: rgb(85, 85, 85); font-size: 14px;\">{SIGNATURE}</p>  </div> </div></div>', '', 'default', '', 0),
(44, 'proposal_commented', 'Proposal #{PROPOSAL_ID}', '<div style=\"background-color: #eeeeef; padding: 50px 0; \"> <div style=\"max-width:640px; margin:0 auto; \"> <div style=\"color: #fff; text-align: center; background-color:#33333e; padding: 30px; border-top-left-radius: 3px; border-top-right-radius: 3px; margin: 0;\"><h1>Proposal #{PROPOSAL_ID} Replies</h1></div><div style=\"padding: 20px; background-color: rgb(255, 255, 255);\"><p style=\"\"><span style=\"line-height: 18.5714px;\">{COMMENT_CONTENT}</span></p><p style=\"\"><span style=\"line-height: 18.5714px;\"><br></span></p><p style=\"\"><span style=\"color: rgb(85, 85, 85); font-size: 14px; line-height: 20px;\"><a style=\"background-color: #00b393; padding: 10px 15px; color: #ffffff;\" href=\"{PROPOSAL_URL}\" target=\"_blank\">Show Proposal</a></span></p></div></div></div>', '', 'default', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_estimates`
--

CREATE TABLE `tbl_estimates` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `estimate_request_id` int(11) NOT NULL DEFAULT 0,
  `estimate_date` date NOT NULL,
  `valid_until` date NOT NULL,
  `note` mediumtext DEFAULT NULL,
  `last_email_sent_date` date DEFAULT NULL,
  `status` enum('draft','sent','accepted','declined') NOT NULL DEFAULT 'draft',
  `tax_id` int(11) NOT NULL DEFAULT 0,
  `tax_id2` int(11) NOT NULL DEFAULT 0,
  `discount_type` enum('before_tax','after_tax') NOT NULL,
  `discount_amount` double NOT NULL,
  `discount_amount_type` enum('percentage','fixed_amount') NOT NULL,
  `project_id` int(11) NOT NULL DEFAULT 0,
  `accepted_by` int(11) NOT NULL DEFAULT 0,
  `meta_data` text NOT NULL,
  `created_by` int(11) NOT NULL,
  `signature` text NOT NULL,
  `public_key` text NOT NULL,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_estimate_comments`
--

CREATE TABLE `tbl_estimate_comments` (
  `id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `description` mediumtext NOT NULL,
  `estimate_id` int(11) NOT NULL DEFAULT 0,
  `files` longtext DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_estimate_forms`
--

CREATE TABLE `tbl_estimate_forms` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` longtext NOT NULL,
  `status` enum('active','inactive') NOT NULL,
  `assigned_to` int(11) NOT NULL,
  `public` tinyint(1) NOT NULL DEFAULT 0,
  `enable_attachment` tinyint(4) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_estimate_items`
--

CREATE TABLE `tbl_estimate_items` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text DEFAULT NULL,
  `quantity` double NOT NULL,
  `unit_type` varchar(20) NOT NULL DEFAULT '',
  `rate` double NOT NULL,
  `total` double NOT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `estimate_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_estimate_requests`
--

CREATE TABLE `tbl_estimate_requests` (
  `id` int(11) NOT NULL,
  `estimate_form_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `client_id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `assigned_to` int(11) NOT NULL,
  `status` enum('new','processing','hold','canceled','estimated') NOT NULL DEFAULT 'new',
  `files` mediumtext NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_events`
--

CREATE TABLE `tbl_events` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` mediumtext NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `location` mediumtext DEFAULT NULL,
  `client_id` int(11) NOT NULL DEFAULT 0,
  `labels` text NOT NULL,
  `share_with` mediumtext DEFAULT NULL,
  `editable_google_event` tinyint(1) NOT NULL DEFAULT 0,
  `google_event_id` text NOT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0,
  `lead_id` int(11) NOT NULL DEFAULT 0,
  `ticket_id` int(11) NOT NULL DEFAULT 0,
  `project_id` int(11) NOT NULL DEFAULT 0,
  `task_id` int(11) NOT NULL DEFAULT 0,
  `proposal_id` int(11) NOT NULL DEFAULT 0,
  `contract_id` int(11) NOT NULL DEFAULT 0,
  `subscription_id` int(11) NOT NULL DEFAULT 0,
  `invoice_id` int(11) NOT NULL DEFAULT 0,
  `order_id` int(11) NOT NULL DEFAULT 0,
  `estimate_id` int(11) NOT NULL DEFAULT 0,
  `next_recurring_time` datetime DEFAULT NULL,
  `no_of_cycles_completed` int(11) NOT NULL DEFAULT 0,
  `snoozing_time` datetime DEFAULT NULL,
  `reminder_status` enum('new','shown','done') NOT NULL DEFAULT 'new',
  `type` enum('event','reminder') NOT NULL DEFAULT 'event',
  `color` varchar(15) NOT NULL,
  `recurring` int(11) NOT NULL DEFAULT 0,
  `repeat_every` int(11) NOT NULL DEFAULT 0,
  `repeat_type` enum('days','weeks','months','years') DEFAULT NULL,
  `no_of_cycles` int(11) NOT NULL DEFAULT 0,
  `last_start_date` date DEFAULT NULL,
  `recurring_dates` longtext NOT NULL,
  `confirmed_by` text NOT NULL,
  `rejected_by` text NOT NULL,
  `files` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_event_tracker`
--

CREATE TABLE `tbl_event_tracker` (
  `id` int(11) NOT NULL,
  `event_type` varchar(255) NOT NULL,
  `context` varchar(255) NOT NULL,
  `context_id` int(11) NOT NULL,
  `read_count` int(11) DEFAULT NULL,
  `status` enum('new','read') DEFAULT 'new',
  `last_read_time` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `logs` text DEFAULT NULL,
  `random_id` varchar(10) NOT NULL,
  `deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_expenses`
--

CREATE TABLE `tbl_expenses` (
  `id` int(11) NOT NULL,
  `expense_date` date NOT NULL,
  `category_id` int(11) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `amount` double NOT NULL,
  `files` mediumtext NOT NULL,
  `title` text NOT NULL,
  `project_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `tax_id` int(11) NOT NULL DEFAULT 0,
  `tax_id2` int(11) NOT NULL DEFAULT 0,
  `client_id` int(11) NOT NULL DEFAULT 0,
  `recurring` tinyint(4) NOT NULL DEFAULT 0,
  `recurring_expense_id` tinyint(4) NOT NULL DEFAULT 0,
  `repeat_every` int(11) NOT NULL DEFAULT 0,
  `repeat_type` enum('days','weeks','months','years') DEFAULT NULL,
  `no_of_cycles` int(11) NOT NULL DEFAULT 0,
  `next_recurring_date` date DEFAULT NULL,
  `no_of_cycles_completed` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_expense_categories`
--

CREATE TABLE `tbl_expense_categories` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_expense_categories`
--

INSERT INTO `tbl_expense_categories` (`id`, `title`, `deleted`) VALUES
(1, 'Miscellaneous expense', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_file_category`
--

CREATE TABLE `tbl_file_category` (
  `id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `type` enum('project') NOT NULL DEFAULT 'project',
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_folders`
--

CREATE TABLE `tbl_folders` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `folder_id` varchar(255) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `level` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `permissions` text DEFAULT NULL,
  `context` varchar(255) NOT NULL,
  `context_id` int(11) NOT NULL,
  `starred_by` mediumtext NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_general_files`
--

CREATE TABLE `tbl_general_files` (
  `id` int(11) NOT NULL,
  `file_name` text NOT NULL,
  `file_id` text DEFAULT NULL,
  `service_type` varchar(20) DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `file_size` double NOT NULL,
  `created_at` datetime NOT NULL,
  `client_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `uploaded_by` int(11) NOT NULL,
  `folder_id` int(11) DEFAULT 0,
  `context` varchar(100) NOT NULL,
  `context_id` int(11) DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_help_articles`
--

CREATE TABLE `tbl_help_articles` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` longtext NOT NULL,
  `category_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `files` text NOT NULL,
  `total_views` int(11) NOT NULL DEFAULT 0,
  `sort` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_help_categories`
--

CREATE TABLE `tbl_help_categories` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text NOT NULL,
  `type` enum('help','knowledge_base') NOT NULL,
  `sort` int(11) NOT NULL,
  `articles_order` varchar(3) NOT NULL DEFAULT '',
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_invoices`
--

CREATE TABLE `tbl_invoices` (
  `id` int(11) NOT NULL,
  `type` enum('invoice','credit_note') NOT NULL DEFAULT 'invoice',
  `client_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL DEFAULT 0,
  `bill_date` date NOT NULL,
  `due_date` date NOT NULL,
  `note` mediumtext DEFAULT NULL,
  `labels` text DEFAULT NULL,
  `last_email_sent_date` date DEFAULT NULL,
  `status` enum('draft','not_paid','cancelled','credited') NOT NULL DEFAULT 'draft',
  `tax_id` int(11) NOT NULL DEFAULT 0,
  `tax_id2` int(11) NOT NULL DEFAULT 0,
  `tax_id3` int(11) NOT NULL DEFAULT 0,
  `recurring` tinyint(4) NOT NULL DEFAULT 0,
  `recurring_invoice_id` int(11) NOT NULL DEFAULT 0,
  `repeat_every` int(11) NOT NULL DEFAULT 0,
  `repeat_type` enum('days','weeks','months','years') DEFAULT NULL,
  `no_of_cycles` int(11) NOT NULL DEFAULT 0,
  `next_recurring_date` date DEFAULT NULL,
  `no_of_cycles_completed` int(11) NOT NULL DEFAULT 0,
  `due_reminder_date` date DEFAULT NULL,
  `recurring_reminder_date` date DEFAULT NULL,
  `discount_amount` double NOT NULL,
  `discount_amount_type` enum('percentage','fixed_amount') NOT NULL,
  `discount_type` enum('before_tax','after_tax') NOT NULL,
  `cancelled_at` datetime DEFAULT NULL,
  `cancelled_by` int(11) NOT NULL,
  `files` mediumtext NOT NULL,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `estimate_id` int(11) NOT NULL DEFAULT 0,
  `main_invoice_id` int(11) NOT NULL DEFAULT 0,
  `subscription_id` int(11) NOT NULL DEFAULT 0,
  `invoice_total` double NOT NULL,
  `invoice_subtotal` double NOT NULL,
  `discount_total` double NOT NULL,
  `tax` double NOT NULL,
  `tax2` double NOT NULL,
  `tax3` double NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `order_id` int(11) NOT NULL DEFAULT 0,
  `display_id` text NOT NULL,
  `number_year` int(11) DEFAULT NULL,
  `number_sequence` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_invoice_items`
--

CREATE TABLE `tbl_invoice_items` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text DEFAULT NULL,
  `quantity` double NOT NULL,
  `unit_type` varchar(20) NOT NULL DEFAULT '',
  `rate` double NOT NULL,
  `total` double NOT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `invoice_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL DEFAULT 0,
  `taxable` tinyint(1) NOT NULL DEFAULT 1,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_invoice_payments`
--

CREATE TABLE `tbl_invoice_payments` (
  `id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `payment_date` date NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `invoice_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `transaction_id` tinytext DEFAULT NULL,
  `created_by` int(11) DEFAULT 1,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_items`
--

CREATE TABLE `tbl_items` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text DEFAULT NULL,
  `unit_type` varchar(20) NOT NULL DEFAULT '',
  `rate` double NOT NULL,
  `files` mediumtext NOT NULL,
  `show_in_client_portal` tinyint(1) NOT NULL DEFAULT 0,
  `category_id` int(11) NOT NULL,
  `taxable` tinyint(1) NOT NULL DEFAULT 0,
  `sort` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_item_categories`
--

CREATE TABLE `tbl_item_categories` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_item_categories`
--

INSERT INTO `tbl_item_categories` (`id`, `title`, `deleted`) VALUES
(1, 'General item', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_labels`
--

CREATE TABLE `tbl_labels` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `color` varchar(15) NOT NULL,
  `context` enum('event','invoice','note','project','task','ticket','to_do','subscription','client') DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_leads`
--

CREATE TABLE `tbl_leads` (
  `id` int(11) NOT NULL,
  `company_name` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `zip` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `created_date` date NOT NULL,
  `website` text DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_lead_source`
--

CREATE TABLE `tbl_lead_source` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `sort` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_lead_source`
--

INSERT INTO `tbl_lead_source` (`id`, `title`, `sort`, `deleted`) VALUES
(1, 'Google', 1, 0),
(2, 'Facebook', 2, 0),
(3, 'Twitter', 3, 0),
(4, 'Youtube', 4, 0),
(5, 'Elsewhere', 5, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_lead_status`
--

CREATE TABLE `tbl_lead_status` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `color` varchar(7) NOT NULL,
  `sort` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_lead_status`
--

INSERT INTO `tbl_lead_status` (`id`, `title`, `color`, `sort`, `deleted`) VALUES
(1, 'New', '#f1c40f', 0, 0),
(2, 'Qualified', '#2d9cdb', 1, 0),
(3, 'Discussion', '#29c2c2', 2, 0),
(4, 'Negotiation', '#2d9cdb', 3, 0),
(5, 'Won', '#83c340', 4, 0),
(6, 'Lost', '#e74c3c', 5, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_leave_applications`
--

CREATE TABLE `tbl_leave_applications` (
  `id` int(11) NOT NULL,
  `leave_type_id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `total_hours` decimal(7,2) NOT NULL,
  `total_days` decimal(5,2) NOT NULL,
  `applicant_id` int(11) NOT NULL,
  `reason` mediumtext NOT NULL,
  `status` enum('pending','approved','rejected','canceled') NOT NULL DEFAULT 'pending',
  `created_at` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `checked_at` datetime DEFAULT NULL,
  `checked_by` int(11) NOT NULL DEFAULT 0,
  `files` text NOT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_leave_types`
--

CREATE TABLE `tbl_leave_types` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `color` varchar(7) NOT NULL,
  `description` text DEFAULT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_leave_types`
--

INSERT INTO `tbl_leave_types` (`id`, `title`, `status`, `color`, `description`, `deleted`) VALUES
(1, 'Casual Leave', 'active', '#83c340', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_likes`
--

CREATE TABLE `tbl_likes` (
  `id` int(11) NOT NULL,
  `project_comment_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_messages`
--

CREATE TABLE `tbl_messages` (
  `id` int(11) NOT NULL,
  `subject` varchar(255) NOT NULL DEFAULT 'Untitled',
  `message` mediumtext NOT NULL,
  `created_at` datetime NOT NULL,
  `from_user_id` int(11) NOT NULL,
  `to_user_id` int(11) NOT NULL,
  `status` enum('unread','read') NOT NULL DEFAULT 'unread',
  `message_id` int(11) NOT NULL DEFAULT 0,
  `deleted` int(11) NOT NULL DEFAULT 0,
  `files` longtext NOT NULL,
  `deleted_by_users` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_milestones`
--

CREATE TABLE `tbl_milestones` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `project_id` int(11) NOT NULL,
  `due_date` date NOT NULL,
  `description` text NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_notes`
--

CREATE TABLE `tbl_notes` (
  `id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `title` text NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `project_id` int(11) NOT NULL DEFAULT 0,
  `client_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `labels` text DEFAULT NULL,
  `files` mediumtext NOT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_notifications`
--

CREATE TABLE `tbl_notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `description` longtext NOT NULL,
  `created_at` datetime NOT NULL,
  `notify_to` mediumtext NOT NULL,
  `read_by` mediumtext NOT NULL,
  `event` varchar(250) NOT NULL,
  `project_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `project_comment_id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `ticket_comment_id` int(11) NOT NULL,
  `project_file_id` int(11) NOT NULL,
  `leave_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `to_user_id` int(11) NOT NULL,
  `activity_log_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `invoice_payment_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `estimate_id` int(11) NOT NULL,
  `contract_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `estimate_request_id` int(11) NOT NULL,
  `actual_message_id` int(11) NOT NULL,
  `parent_message_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `announcement_id` int(11) NOT NULL,
  `proposal_id` int(11) NOT NULL,
  `estimate_comment_id` int(11) NOT NULL,
  `subscription_id` int(11) NOT NULL,
  `expense_id` int(11) NOT NULL,
  `proposal_comment_id` int(11) NOT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_notification_settings`
--

CREATE TABLE `tbl_notification_settings` (
  `id` int(11) NOT NULL,
  `event` varchar(250) NOT NULL,
  `category` varchar(50) NOT NULL,
  `enable_email` int(11) NOT NULL DEFAULT 0,
  `enable_web` int(11) NOT NULL DEFAULT 0,
  `enable_slack` int(11) NOT NULL DEFAULT 0,
  `notify_to_team` text NOT NULL,
  `notify_to_team_members` text NOT NULL,
  `notify_to_terms` text NOT NULL,
  `sort` int(11) NOT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_notification_settings`
--

INSERT INTO `tbl_notification_settings` (`id`, `event`, `category`, `enable_email`, `enable_web`, `enable_slack`, `notify_to_team`, `notify_to_team_members`, `notify_to_terms`, `sort`, `deleted`) VALUES
(1, 'project_created', 'project', 0, 0, 0, '', '', '', 1, 0),
(2, 'project_deleted', 'project', 0, 0, 0, '', '', '', 2, 0),
(3, 'project_task_created', 'project', 0, 1, 0, '', '', 'task_assignee,task_collaborators', 3, 0),
(4, 'project_task_updated', 'project', 0, 1, 0, '', '', 'task_assignee,task_collaborators', 4, 0),
(5, 'project_task_assigned', 'project', 0, 1, 0, '', '', 'task_assignee,task_collaborators', 5, 0),
(7, 'project_task_started', 'project', 0, 0, 0, '', '', '', 7, 0),
(8, 'project_task_finished', 'project', 0, 0, 0, '', '', '', 8, 0),
(9, 'project_task_reopened', 'project', 0, 0, 0, '', '', '', 9, 0),
(10, 'project_task_deleted', 'project', 0, 1, 0, '', '', 'task_assignee,task_collaborators', 10, 0),
(11, 'project_task_commented', 'project', 0, 1, 0, '', '', 'task_assignee,task_collaborators,mentioned_members', 11, 0),
(12, 'project_member_added', 'project', 0, 1, 0, '', '', 'project_members', 12, 0),
(13, 'project_member_deleted', 'project', 0, 1, 0, '', '', 'project_members', 13, 0),
(14, 'project_file_added', 'project', 0, 1, 0, '', '', 'project_members', 14, 0),
(15, 'project_file_deleted', 'project', 0, 1, 0, '', '', 'project_members', 15, 0),
(16, 'project_file_commented', 'project', 0, 1, 0, '', '', 'project_members,mentioned_members', 16, 0),
(17, 'project_comment_added', 'project', 0, 1, 0, '', '', 'project_members,mentioned_members', 17, 0),
(18, 'project_comment_replied', 'project', 0, 1, 0, '', '', 'project_members,comment_creator,mentioned_members', 18, 0),
(19, 'project_customer_feedback_added', 'project', 0, 1, 0, '', '', 'project_members,mentioned_members', 19, 0),
(20, 'project_customer_feedback_replied', 'project', 0, 1, 0, '', '', 'project_members,client_primary_contact,comment_creator,mentioned_members', 20, 0),
(21, 'client_signup', 'client', 0, 0, 0, '', '', '', 21, 0),
(22, 'invoice_online_payment_received', 'invoice', 0, 0, 0, '', '', '', 22, 0),
(23, 'leave_application_submitted', 'leave', 0, 0, 0, '', '', '', 23, 0),
(24, 'leave_approved', 'leave', 0, 1, 0, '', '', 'leave_applicant', 24, 0),
(25, 'leave_assigned', 'leave', 0, 1, 0, '', '', 'leave_applicant', 25, 0),
(26, 'leave_rejected', 'leave', 0, 1, 0, '', '', 'leave_applicant', 26, 0),
(27, 'leave_canceled', 'leave', 0, 0, 0, '', '', '', 27, 0),
(28, 'ticket_created', 'ticket', 0, 0, 0, '', '', 'ticket_assignee', 28, 0),
(29, 'ticket_commented', 'ticket', 0, 1, 0, '', '', 'client_primary_contact,ticket_creator,ticket_assignee', 29, 0),
(30, 'ticket_closed', 'ticket', 0, 1, 0, '', '', 'client_primary_contact,ticket_creator,ticket_assignee', 30, 0),
(31, 'ticket_reopened', 'ticket', 0, 1, 0, '', '', 'client_primary_contact,ticket_creator,ticket_assignee', 31, 0),
(32, 'estimate_request_received', 'estimate', 0, 0, 0, '', '', '', 32, 0),
(34, 'estimate_accepted', 'estimate', 0, 0, 0, '', '', '', 34, 0),
(35, 'estimate_rejected', 'estimate', 0, 0, 0, '', '', '', 35, 0),
(36, 'new_message_sent', 'message', 0, 0, 0, '', '', '', 36, 0),
(37, 'message_reply_sent', 'message', 0, 0, 0, '', '', '', 37, 0),
(38, 'invoice_payment_confirmation', 'invoice', 0, 0, 0, '', '', '', 22, 0),
(39, 'new_event_added_in_calendar', 'event', 0, 1, 0, '', '', 'recipient', 39, 0),
(40, 'recurring_invoice_created_vai_cron_job', 'invoice', 0, 0, 0, '', '', 'client_primary_contact', 22, 0),
(41, 'new_announcement_created', 'announcement', 0, 1, 0, '', '', 'recipient', 41, 0),
(42, 'invoice_due_reminder_before_due_date', 'invoice', 0, 1, 0, '', '', 'client_primary_contact', 22, 0),
(43, 'invoice_overdue_reminder', 'invoice', 0, 1, 0, '', '', 'client_primary_contact', 22, 0),
(44, 'recurring_invoice_creation_reminder', 'invoice', 0, 0, 0, '', '', '', 22, 0),
(45, 'project_completed', 'project', 0, 0, 0, '', '', '', 2, 0),
(46, 'lead_created', 'lead', 0, 0, 0, '', '', '', 21, 0),
(47, 'client_created_from_lead', 'lead', 0, 0, 0, '', '', '', 21, 0),
(48, 'project_task_deadline_pre_reminder', 'project', 0, 1, 0, '', '', 'task_assignee', 20, 0),
(49, 'project_task_reminder_on_the_day_of_deadline', 'project', 0, 1, 0, '', '', 'task_assignee', 20, 0),
(50, 'project_task_deadline_overdue_reminder', 'project', 0, 1, 0, '', '', 'task_assignee', 20, 0),
(51, 'recurring_task_created_via_cron_job', 'project', 0, 1, 0, '', '', 'project_members,task_assignee', 20, 0),
(52, 'calendar_event_modified', 'event', 0, 0, 0, '', '', '', 39, 0),
(53, 'client_contact_requested_account_removal', 'client', 0, 0, 0, '', '', '', 21, 0),
(54, 'bitbucket_push_received', 'project', 0, 0, 0, '', '', '', 45, 0),
(55, 'github_push_received', 'project', 0, 0, 0, '', '', '', 45, 0),
(56, 'invited_client_contact_signed_up', 'client', 0, 0, 0, '', '', '', 21, 0),
(57, 'created_a_new_post', 'timeline', 0, 0, 0, '', '', '', 52, 0),
(58, 'timeline_post_commented', 'timeline', 0, 1, 0, '', '', 'post_creator', 52, 0),
(59, 'ticket_assigned', 'ticket', 0, 1, 0, '', '', 'ticket_assignee', 31, 0),
(60, 'new_order_received', 'order', 0, 0, 0, '', '', '', 1, 0),
(61, 'order_status_updated', 'order', 0, 0, 0, '', '', '', 2, 0),
(62, 'proposal_accepted', 'proposal', 0, 0, 0, '', '', '', 34, 0),
(63, 'proposal_rejected', 'proposal', 0, 0, 0, '', '', '', 35, 0),
(64, 'estimate_commented', 'estimate', 0, 0, 0, '', '', '', 35, 0),
(65, 'invoice_manual_payment_added', 'invoice', 0, 0, 0, '', '', '', 22, 0),
(66, 'contract_accepted', 'contract', 0, 0, 0, '', '', '', 66, 0),
(67, 'contract_rejected', 'contract', 0, 0, 0, '', '', '', 67, 0),
(68, 'subscription_request_sent', 'subscription', 0, 1, 0, '', '', 'client_primary_contact', 68, 0),
(69, 'subscription_started', 'subscription', 0, 1, 0, '', '', 'client_primary_contact', 68, 0),
(70, 'subscription_invoice_created_via_cron_job', 'subscription', 0, 1, 0, '', '', 'client_primary_contact', 68, 0),
(71, 'general_task_created', 'general_task', 0, 1, 0, '', '', 'task_assignee,task_collaborators', 69, 0),
(72, 'general_task_updated', 'general_task', 0, 1, 0, '', '', 'task_assignee,task_collaborators', 70, 0),
(73, 'general_task_assigned', 'general_task', 0, 1, 0, '', '', 'task_assignee,task_collaborators', 71, 0),
(74, 'general_task_started', 'general_task', 0, 0, 0, '', '', '', 72, 0),
(75, 'general_task_finished', 'general_task', 0, 0, 0, '', '', '', 73, 0),
(76, 'general_task_reopened', 'general_task', 0, 0, 0, '', '', '', 74, 0),
(77, 'general_task_deleted', 'general_task', 0, 1, 0, '', '', 'task_assignee,task_collaborators', 75, 0),
(78, 'general_task_commented', 'general_task', 0, 1, 0, '', '', 'task_assignee,task_collaborators,mentioned_members', 76, 0),
(79, 'proposal_commented', 'proposal', 0, 0, 0, '', '', '', 77, 0),
(80, 'subscription_cancelled', 'subscription', 0, 0, 0, '', '', '', 68, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_orders`
--

CREATE TABLE `tbl_orders` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `note` mediumtext DEFAULT NULL,
  `status_id` int(11) NOT NULL,
  `tax_id` int(11) NOT NULL DEFAULT 0,
  `tax_id2` int(11) NOT NULL DEFAULT 0,
  `discount_amount` double NOT NULL,
  `discount_amount_type` enum('percentage','fixed_amount') NOT NULL,
  `discount_type` enum('before_tax','after_tax') NOT NULL,
  `created_by` int(11) NOT NULL DEFAULT 0,
  `project_id` int(11) NOT NULL DEFAULT 0,
  `files` longtext NOT NULL,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `created_by_hash` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_order_items`
--

CREATE TABLE `tbl_order_items` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text DEFAULT NULL,
  `quantity` double NOT NULL,
  `unit_type` varchar(20) NOT NULL DEFAULT '',
  `rate` double NOT NULL,
  `total` double NOT NULL,
  `order_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `item_id` int(11) NOT NULL DEFAULT 0,
  `sort` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `created_by_hash` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_order_status`
--

CREATE TABLE `tbl_order_status` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `color` varchar(7) NOT NULL,
  `sort` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_order_status`
--

INSERT INTO `tbl_order_status` (`id`, `title`, `color`, `sort`, `deleted`) VALUES
(1, 'New', '#f1c40f', 0, 0),
(2, 'Processing', '#29c2c2', 1, 0),
(3, 'Confirmed', '#83c340', 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pages`
--

CREATE TABLE `tbl_pages` (
  `id` int(11) NOT NULL,
  `title` text DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `slug` text DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `internal_use_only` tinyint(1) NOT NULL DEFAULT 0,
  `visible_to_team_members_only` tinyint(1) NOT NULL DEFAULT 0,
  `visible_to_clients_only` tinyint(1) NOT NULL DEFAULT 0,
  `full_width` tinyint(1) NOT NULL DEFAULT 0,
  `hide_topbar` tinyint(1) NOT NULL DEFAULT 0,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_payment_methods`
--

CREATE TABLE `tbl_payment_methods` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `type` varchar(100) NOT NULL DEFAULT 'custom',
  `description` text NOT NULL,
  `online_payable` tinyint(1) NOT NULL DEFAULT 0,
  `available_on_invoice` tinyint(1) NOT NULL DEFAULT 0,
  `minimum_payment_amount` double NOT NULL DEFAULT 0,
  `settings` longtext NOT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_payment_methods`
--

INSERT INTO `tbl_payment_methods` (`id`, `title`, `type`, `description`, `online_payable`, `available_on_invoice`, `minimum_payment_amount`, `settings`, `sort`, `deleted`) VALUES
(1, 'Cash', 'custom', 'Cash payments', 0, 0, 0, '', 0, 0),
(2, 'Stripe', 'stripe', 'Stripe online payments', 1, 0, 0, 'a:3:{s:15:\"pay_button_text\";s:6:\"Stripe\";s:10:\"secret_key\";s:6:\"\";s:15:\"publishable_key\";s:6:\"\";}', 0, 0),
(3, 'PayPal Payments Standard', 'paypal_payments_standard', 'PayPal Payments Standard Online Payments', 1, 0, 0, 'a:4:{s:15:\"pay_button_text\";s:6:\"PayPal\";s:5:\"email\";s:4:\"\";s:11:\"paypal_live\";s:1:\"0\";s:5:\"debug\";s:1:\"0\";}', 0, 0),
(4, 'Paytm', 'paytm', 'Paytm online payments', 1, 0, 0, '', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_paypal_ipn`
--

CREATE TABLE `tbl_paypal_ipn` (
  `id` int(11) NOT NULL,
  `verification_code` text NOT NULL,
  `payment_verification_code` text NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `contact_user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pin_comments`
--

CREATE TABLE `tbl_pin_comments` (
  `id` int(11) NOT NULL,
  `project_comment_id` int(11) NOT NULL,
  `pinned_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_posts`
--

CREATE TABLE `tbl_posts` (
  `id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `description` mediumtext NOT NULL,
  `post_id` int(11) NOT NULL,
  `share_with` text DEFAULT NULL,
  `files` longtext DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_projects`
--

CREATE TABLE `tbl_projects` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `project_type` enum('client_project','internal_project') NOT NULL DEFAULT 'client_project',
  `start_date` date DEFAULT NULL,
  `deadline` date DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `created_date` date DEFAULT NULL,
  `created_by` int(11) NOT NULL DEFAULT 0,
  `status` enum('open','completed','hold','canceled') NOT NULL DEFAULT 'open',
  `status_id` int(11) NOT NULL DEFAULT 1,
  `labels` text DEFAULT NULL,
  `price` double NOT NULL DEFAULT 0,
  `starred_by` mediumtext NOT NULL,
  `estimate_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_project_comments`
--

CREATE TABLE `tbl_project_comments` (
  `id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `description` mediumtext NOT NULL,
  `project_id` int(11) NOT NULL DEFAULT 0,
  `comment_id` int(11) NOT NULL DEFAULT 0,
  `task_id` int(11) NOT NULL DEFAULT 0,
  `file_id` int(11) NOT NULL DEFAULT 0,
  `customer_feedback_id` int(11) NOT NULL DEFAULT 0,
  `files` longtext DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_project_files`
--

CREATE TABLE `tbl_project_files` (
  `id` int(11) NOT NULL,
  `file_name` text NOT NULL,
  `file_id` text DEFAULT NULL,
  `service_type` varchar(20) DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `file_size` double NOT NULL,
  `created_at` datetime NOT NULL,
  `project_id` int(11) NOT NULL,
  `uploaded_by` int(11) NOT NULL,
  `category_id` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_project_members`
--

CREATE TABLE `tbl_project_members` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `is_leader` tinyint(1) DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_project_settings`
--

CREATE TABLE `tbl_project_settings` (
  `project_id` int(11) NOT NULL,
  `setting_name` varchar(100) NOT NULL,
  `setting_value` mediumtext NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_project_status`
--

CREATE TABLE `tbl_project_status` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `title_language_key` text NOT NULL,
  `key_name` varchar(100) NOT NULL,
  `icon` varchar(50) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_project_status`
--

INSERT INTO `tbl_project_status` (`id`, `title`, `title_language_key`, `key_name`, `icon`, `deleted`) VALUES
(1, 'Open', 'open', 'open', 'grid', 0),
(2, 'Completed', 'completed', 'completed', 'check-circle', 0),
(3, 'Hold', 'hold', '', 'pause-circle', 0),
(4, 'Canceled', 'canceled', '', 'x-circle', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_project_time`
--

CREATE TABLE `tbl_project_time` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `hours` float NOT NULL,
  `status` enum('open','logged','approved') NOT NULL DEFAULT 'logged',
  `note` text DEFAULT NULL,
  `task_id` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_proposals`
--

CREATE TABLE `tbl_proposals` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `proposal_date` date NOT NULL,
  `valid_until` date NOT NULL,
  `note` mediumtext DEFAULT NULL,
  `last_email_sent_date` date DEFAULT NULL,
  `status` enum('draft','sent','accepted','declined') NOT NULL DEFAULT 'draft',
  `tax_id` int(11) NOT NULL DEFAULT 0,
  `tax_id2` int(11) NOT NULL DEFAULT 0,
  `discount_type` enum('before_tax','after_tax') NOT NULL,
  `discount_amount` double NOT NULL,
  `discount_amount_type` enum('percentage','fixed_amount') NOT NULL,
  `content` mediumtext NOT NULL,
  `public_key` varchar(10) NOT NULL,
  `accepted_by` int(11) NOT NULL DEFAULT 0,
  `created_by` int(11) NOT NULL DEFAULT 0,
  `total_views` int(11) NOT NULL DEFAULT 0,
  `last_preview_seen` datetime DEFAULT NULL,
  `meta_data` text NOT NULL,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_proposal_comments`
--

CREATE TABLE `tbl_proposal_comments` (
  `id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `description` mediumtext NOT NULL,
  `proposal_id` int(11) NOT NULL DEFAULT 0,
  `files` longtext DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_proposal_items`
--

CREATE TABLE `tbl_proposal_items` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text DEFAULT NULL,
  `quantity` double NOT NULL,
  `unit_type` varchar(20) NOT NULL DEFAULT '',
  `rate` double NOT NULL,
  `total` double NOT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `proposal_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_proposal_templates`
--

CREATE TABLE `tbl_proposal_templates` (
  `id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `template` mediumtext DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_proposal_templates`
--

INSERT INTO `tbl_proposal_templates` (`id`, `title`, `template`, `deleted`) VALUES
(1, 'Template 3.6', '<table style=\"background-color:#3D3D3D; color:#fff;\" class=\"table\"><tbody><tr><td style=\"text-align: center; \"><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><div style=\"font-size:40px;\"><b>Web Design Proposal</b></div><p></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p><p><br></p></td></tr></tbody></table><p style=\"text-align: justify; \"><br></p><p style=\"text-align: justify; \">In response to the growing demands and opportunities within the industry, we propose to develop a comprehensive solution tailored to address key challenges and capitalize on emerging trends. Our proposal aims to deliver tangible value by leveraging our expertise, innovative approaches, and commitment to excellence.</p>\n\n<table style=\"margin-top: 0; margin-bottom: 10px;\">\n    <tbody>\n        <tr>\n            <td style=\"padding: 0;\">\n                <div style=\"margin-top: 20px\">\n                    <div style=\"text-align: center\">\n                        <div style=\"font-size: 30px\">{PROPOSAL_ID}</div>\n\n<table style=\"margin-top: 10px;\"><tbody><tr><td></td><td></td><td></td><td><div style=\"border-bottom: 5px solid #ff9800;\"></div></td><td></td><td></td><td></td></tr></tbody></table>\n                    </div>\n                </div>\n            </td>\n        </tr>\n    </tbody>\n</table>\n\n<div>\nProposal Date: {PROPOSAL_DATE}<br>\nExpiry Date: {PROPOSAL_EXPIRY_DATE}\n</div>\n<table style=\"width: 100%; padding-top: 30px; margin-top: 0;\">\n<tbody>\n<tr>\n<td style=\"width: 50%;padding-left:0; padding-right: 10px;\"><p>Proposal For</p>{PROPOSAL_TO_INFO}</td>\n<td style=\"width: 50%; padding-left: 10px;\"><p>Proposal From</p>{COMPANY_INFO}</td>\n</tr>\n</tbody>\n</table>\n\n<br pagebreak=\"true\">\n<table style=\"margin-top: 0; margin-bottom: 10px;\">\n    <tbody>\n        <tr>\n            <td style=\"padding: 0;\">\n                <div style=\"margin-top: 20px\">\n                    <div style=\"text-align: center\">\n                        <div style=\"font-size: 30px\">Our Best Offer</div>\n                        \n<table style=\"margin-top: 10px;\"><tbody><tr><td></td><td></td><td></td><td><div style=\"border-bottom: 5px solid #ff9800;\"></div></td><td></td><td></td><td></td></tr></tbody></table>\n                    </div>\n                </div>\n            </td>\n        </tr>\n    </tbody>\n</table>\n<p style=\"text-align: justify; \">In consideration of your unique needs and aspirations, we are pleased to present our best offer, crafted with meticulous attention to detail and driven by a commitment to delivering exceptional value.</p><p><br></p>\n\n{PROPOSAL_ITEMS}<p></p><p><br></p><p><br></p><p></p>\n\n<br pagebreak=\"true\">\n\n<table style=\"margin-top: 0; margin-bottom: 10px;\">\n    <tbody>\n        <tr>\n            <td style=\"padding: 0;\">\n                <div style=\"margin-top: 20px\">\n                    <div style=\"text-align: center\">\n                        <div style=\"font-size: 30px\">Our Objective</div>\n                        \n<table style=\"margin-top: 10px;\"><tbody><tr><td></td><td></td><td></td><td><div style=\"border-bottom: 5px solid #ff9800;\"></div></td><td></td><td></td><td></td></tr></tbody></table>\n                    </div>\n                </div>\n            </td>\n        </tr>\n    </tbody>\n</table>\n<p style=\"text-align: justify; \">Our objective is to align seamlessly with your business goals, leveraging our expertise and resources to drive tangible results and foster long-term success.</p>\n<table style=\"width: 100%;\">\n<tbody><tr>\n<td style=\"width: 50%;vertical-align: top;\">\n<span class=\"timeline-images inline-block\"><img class=\"pasted-image\" src=\"/assets/images/image_preview.png\" alt=\"\" style=\"width:100%;\"></span><span class=\"timeline-images inline-block\"></span>\n</td>\n<td style=\"width: 50%;vertical-align: top;\">\n<span style=\"width: 100%; float: left;\">\n<div style=\"line-height: 26px; padding: 0px 0px 30px;vertical-align:top;\"><span>Through a collaborative partnership, we aim to understand your unique challenges, opportunities, and aspirations, enabling us to tailor our approach to meet your specific needs. By focusing on measurable outcomes, continuous improvement, and proactive communication, we are committed to exceeding your expectations and establishing a foundation for sustained growth and competitiveness in a dynamic business environment.</span><br></div></span>\n</td>\n</tr>\n</tbody></table>\n\n<p></p><p><br></p>\n<br pagebreak=\"true\">\n\n<table style=\"margin-top: 0; \">\n    <tbody>\n        <tr>\n            <td style=\"padding: 0;\">\n                <div style=\"margin-top: 20px\">\n                    <div style=\"text-align: center\">\n                        <div style=\"font-size: 30px\">Our Portfolio</div>\n                        \n<table style=\"margin-top: 10px;\"><tbody><tr><td></td><td></td><td></td><td><div style=\"border-bottom: 5px solid #ff9800;\"></div></td><td></td><td></td><td></td></tr></tbody></table>\n                    </div>\n                </div>\n            </td>\n        </tr>\n    </tbody>\n</table>\n<p style=\"text-align: center;\">Some of our recent work here</p><table class=\"table table-bordered\"><tbody><tr><td><p><span class=\"timeline-images inline-block\"><img class=\"pasted-image\" src=\"/assets/images/image_preview.png\" alt=\"\"></span><span class=\"timeline-images inline-block\"></span><br></p></td><td><p><span class=\"timeline-images inline-block\"></span><span class=\"timeline-images inline-block\"><img class=\"pasted-image\" src=\"/assets/images/image_preview.png\" alt=\"\"></span><br></p></td></tr><tr><td><p><span class=\"timeline-images inline-block\"><img class=\"pasted-image\" src=\"/assets/images/image_preview.png\" alt=\"\"></span><br></p></td><td><p><span class=\"timeline-images inline-block\"><img class=\"pasted-image\" src=\"/assets/images/image_preview.png\" alt=\"\"></span><br></p></td></tr></tbody></table>\n\n<br pagebreak=\"true\">\n<table style=\"margin-top: 0; margin-bottom: 10px;\">\n    <tbody>\n        <tr>\n            <td style=\"padding: 0;\">\n                <div style=\"margin-top: 20px\">\n                    <div style=\"text-align: center\">\n                        <div style=\"font-size: 30px\">Contact Us</div>\n                        \n<table style=\"margin-top: 10px;\"><tbody><tr><td></td><td></td><td></td><td><div style=\"border-bottom: 5px solid #ff9800;\"></div></td><td></td><td></td><td></td></tr></tbody></table>\n                    </div>\n                </div>\n            </td>\n        </tr>\n    </tbody>\n</table>\n<p style=\"text-align: center; \">We are looking forward to working with you. Please feel free to contact us.\n</p><p><br></p><p></p><p></p>', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_roles`
--

CREATE TABLE `tbl_roles` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `permissions` mediumtext DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_settings`
--

CREATE TABLE `tbl_settings` (
  `setting_name` varchar(100) NOT NULL,
  `setting_value` mediumtext NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'app',
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_settings`
--

INSERT INTO `tbl_settings` (`setting_name`, `setting_value`, `type`, `deleted`) VALUES
('accepted_file_formats', 'jpg,jpeg,png,doc,xlsx,txt,pdf,zip,webm', 'app', 0),
('allowed_ip_addresses', '', 'app', 0),
('app_title', 'RISE - Ultimate Project Manager and CRM', 'app', 0),
('contract_color', '#000000', 'app', 0),
('currency_symbol', '$', 'app', 0),
('date_format', 'Y-m-d', 'app', 0),
('decimal_separator', '.', 'app', 0),
('default_contract_template', '1', 'app', 0),
('default_currency', 'USD', 'app', 0),
('default_due_date_after_billing_date', '14', 'app', 0),
('default_permissions_for_non_primary_contact', 'projects', 'app', 0),
('default_proposal_template', '1', 'app', 0),
('default_theme_color', 'F2F2F2', 'app', 0),
('email_sent_from_address', 'admin@admin.com', 'app', 0),
('email_sent_from_name', 'Super', 'app', 0),
('enable_audio_recording', '1', 'app', 0),
('estimate_color', '#000000', 'app', 0),
('first_day_of_week', '0', 'app', 0),
('invoice_color', '#000000', 'app', 0),
('invoice_item_list_background', '#f4f4f4', 'app', 0),
('invoice_logo', 'default-invoice-logo.png', 'app', 0),
('invoice_prefix', 'INVOICE #', 'app', 0),
('item_purchase_code', 'cb876973-b5d3-4ea6-8769-a843e380428c', 'app', 0),
('module_announcement', '1', 'app', 0),
('module_attendance', '1', 'app', 0),
('module_chat', '1', 'app', 0),
('module_contract', '1', 'app', 0),
('module_estimate', '1', 'app', 0),
('module_estimate_request', '1', 'app', 0),
('module_event', '1', 'app', 0),
('module_expense', '1', 'app', 0),
('module_file_manager', '1', 'app', 0),
('module_gantt', '1', 'app', 0),
('module_help', '1', 'app', 0),
('module_invoice', '1', 'app', 0),
('module_knowledge_base', '1', 'app', 0),
('module_lead', '1', 'app', 0),
('module_leave', '1', 'app', 0),
('module_message', '1', 'app', 0),
('module_note', '1', 'app', 0),
('module_order', '1', 'app', 0),
('module_project_timesheet', '1', 'app', 0),
('module_proposal', '1', 'app', 0),
('module_reminder', '1', 'app', 0),
('module_subscription', '1', 'app', 0),
('module_ticket', '1', 'app', 0),
('module_timeline', '1', 'app', 0),
('module_todo', '1', 'app', 0),
('order_color', '#000000', 'app', 0),
('proposal_color', '#000000', 'app', 0),
('show_theme_color_changer', 'yes', 'app', 0),
('signin_page_background', 'sigin-background-image.jpg', 'app', 0),
('site_logo', 'default-stie-logo.png', 'app', 0),
('task_point_range', '5', 'app', 0),
('time_format', 'small', 'app', 0),
('timezone', 'UTC', 'app', 0),
('user_1_dashboard', '', 'user', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_social_links`
--

CREATE TABLE `tbl_social_links` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `facebook` text DEFAULT NULL,
  `twitter` text DEFAULT NULL,
  `linkedin` text DEFAULT NULL,
  `googleplus` text DEFAULT NULL,
  `digg` text DEFAULT NULL,
  `youtube` text DEFAULT NULL,
  `pinterest` text DEFAULT NULL,
  `instagram` text DEFAULT NULL,
  `github` text DEFAULT NULL,
  `tumblr` text DEFAULT NULL,
  `vine` text DEFAULT NULL,
  `whatsapp` text DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_stripe_ipn`
--

CREATE TABLE `tbl_stripe_ipn` (
  `id` int(11) NOT NULL,
  `session_id` text NOT NULL,
  `verification_code` text NOT NULL,
  `payment_verification_code` text NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `contact_user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `setup_intent` text NOT NULL,
  `subscription_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_subscriptions`
--

CREATE TABLE `tbl_subscriptions` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `client_id` int(11) NOT NULL,
  `bill_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `note` mediumtext DEFAULT NULL,
  `labels` text NOT NULL,
  `status` enum('draft','pending','active','cancelled') NOT NULL DEFAULT 'draft',
  `payment_status` enum('success','failed') NOT NULL DEFAULT 'success',
  `tax_id` int(11) NOT NULL DEFAULT 0,
  `tax_id2` int(11) NOT NULL DEFAULT 0,
  `repeat_every` int(11) NOT NULL DEFAULT 1,
  `repeat_type` enum('days','weeks','months','years') DEFAULT NULL,
  `no_of_cycles` int(11) NOT NULL DEFAULT 0,
  `next_recurring_date` date DEFAULT NULL,
  `no_of_cycles_completed` int(11) NOT NULL DEFAULT 0,
  `cancelled_at` datetime DEFAULT NULL,
  `cancelled_by` int(11) NOT NULL,
  `files` mediumtext NOT NULL,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `type` enum('app','stripe') NOT NULL DEFAULT 'app',
  `stripe_subscription_id` text NOT NULL,
  `stripe_product_id` text NOT NULL,
  `stripe_product_price_id` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_subscription_items`
--

CREATE TABLE `tbl_subscription_items` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text DEFAULT NULL,
  `quantity` double NOT NULL,
  `unit_type` varchar(20) NOT NULL DEFAULT '',
  `rate` double NOT NULL,
  `total` double NOT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `subscription_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_tasks`
--

CREATE TABLE `tbl_tasks` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `project_id` int(11) NOT NULL,
  `milestone_id` int(11) NOT NULL DEFAULT 0,
  `assigned_to` int(11) NOT NULL,
  `deadline` datetime DEFAULT NULL,
  `labels` text DEFAULT NULL,
  `points` tinyint(4) NOT NULL DEFAULT 1,
  `status` enum('to_do','in_progress','done') NOT NULL DEFAULT 'to_do',
  `status_id` int(11) NOT NULL,
  `priority_id` int(11) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `collaborators` text NOT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `recurring` tinyint(1) NOT NULL DEFAULT 0,
  `repeat_every` int(11) NOT NULL DEFAULT 0,
  `repeat_type` enum('days','weeks','months','years') DEFAULT NULL,
  `no_of_cycles` int(11) NOT NULL DEFAULT 0,
  `recurring_task_id` int(11) NOT NULL DEFAULT 0,
  `no_of_cycles_completed` int(11) NOT NULL DEFAULT 0,
  `created_date` date DEFAULT NULL,
  `blocking` text NOT NULL,
  `blocked_by` text NOT NULL,
  `parent_task_id` int(11) NOT NULL,
  `next_recurring_date` date DEFAULT NULL,
  `reminder_date` date DEFAULT NULL,
  `ticket_id` int(11) NOT NULL,
  `status_changed_at` datetime DEFAULT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT 0,
  `expense_id` int(11) NOT NULL DEFAULT 0,
  `subscription_id` int(11) NOT NULL DEFAULT 0,
  `proposal_id` int(11) NOT NULL DEFAULT 0,
  `contract_id` int(11) NOT NULL DEFAULT 0,
  `order_id` int(11) NOT NULL DEFAULT 0,
  `estimate_id` int(11) NOT NULL DEFAULT 0,
  `invoice_id` int(11) NOT NULL DEFAULT 0,
  `lead_id` int(11) NOT NULL DEFAULT 0,
  `client_id` int(11) NOT NULL DEFAULT 0,
  `context` enum('project','client','lead','invoice','estimate','order','contract','proposal','subscription','ticket','expense') NOT NULL DEFAULT 'project'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_task_priority`
--

CREATE TABLE `tbl_task_priority` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `icon` varchar(20) NOT NULL,
  `color` varchar(7) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_task_priority`
--

INSERT INTO `tbl_task_priority` (`id`, `title`, `icon`, `color`, `deleted`) VALUES
(1, 'Minor', 'arrow-down', '#aab7b7', 0),
(2, 'Major', 'arrow-up', '#e18a00', 0),
(3, 'Critical ', 'alert-circle', '#ad159e', 0),
(4, 'Blocker ', 'alert-octagon', '#e74c3c', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_task_status`
--

CREATE TABLE `tbl_task_status` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `key_name` varchar(100) NOT NULL,
  `color` varchar(7) NOT NULL,
  `sort` int(11) NOT NULL,
  `hide_from_kanban` tinyint(1) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `hide_from_non_project_related_tasks` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_task_status`
--

INSERT INTO `tbl_task_status` (`id`, `title`, `key_name`, `color`, `sort`, `hide_from_kanban`, `deleted`, `hide_from_non_project_related_tasks`) VALUES
(1, 'To Do', 'to_do', '#F9A52D', 0, 0, 0, 0),
(2, 'In progress', 'in_progress', '#1672B9', 1, 0, 0, 0),
(3, 'Done', 'done', '#00B393', 2, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_taxes`
--

CREATE TABLE `tbl_taxes` (
  `id` int(11) NOT NULL,
  `title` tinytext NOT NULL,
  `percentage` double NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `stripe_tax_id` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_taxes`
--

INSERT INTO `tbl_taxes` (`id`, `title`, `percentage`, `deleted`, `stripe_tax_id`) VALUES
(1, 'Tax (10%)', 10, 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_team`
--

CREATE TABLE `tbl_team` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `members` mediumtext NOT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_team_member_job_info`
--

CREATE TABLE `tbl_team_member_job_info` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_of_hire` date DEFAULT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0,
  `salary` double NOT NULL DEFAULT 0,
  `salary_term` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_tickets`
--

CREATE TABLE `tbl_tickets` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL DEFAULT 0,
  `ticket_type_id` int(11) NOT NULL,
  `title` text NOT NULL,
  `created_by` int(11) NOT NULL,
  `requested_by` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL,
  `status` enum('new','client_replied','open','closed') NOT NULL DEFAULT 'new',
  `last_activity_at` datetime DEFAULT NULL,
  `assigned_to` int(11) NOT NULL DEFAULT 0,
  `creator_name` varchar(100) NOT NULL,
  `creator_email` varchar(255) NOT NULL,
  `labels` text DEFAULT NULL,
  `task_id` int(11) NOT NULL,
  `closed_at` datetime NOT NULL,
  `merged_with_ticket_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_ticket_comments`
--

CREATE TABLE `tbl_ticket_comments` (
  `id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `description` mediumtext NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `files` longtext DEFAULT NULL,
  `is_note` tinyint(1) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_ticket_templates`
--

CREATE TABLE `tbl_ticket_templates` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` mediumtext NOT NULL,
  `ticket_type_id` int(11) NOT NULL,
  `private` mediumtext NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_ticket_types`
--

CREATE TABLE `tbl_ticket_types` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_ticket_types`
--

INSERT INTO `tbl_ticket_types` (`id`, `title`, `deleted`) VALUES
(1, 'General Support', 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_to_do`
--

CREATE TABLE `tbl_to_do` (
  `id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `title` text NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `labels` text DEFAULT NULL,
  `status` enum('to_do','done') NOT NULL DEFAULT 'to_do',
  `start_date` date DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_users`
--

CREATE TABLE `tbl_users` (
  `id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `user_type` enum('staff','client','lead') NOT NULL DEFAULT 'client',
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `role_id` int(11) NOT NULL DEFAULT 0,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `image` text DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `message_checked_at` datetime DEFAULT NULL,
  `client_id` int(11) NOT NULL DEFAULT 0,
  `notification_checked_at` datetime DEFAULT NULL,
  `is_primary_contact` tinyint(1) NOT NULL DEFAULT 0,
  `job_title` varchar(100) NOT NULL DEFAULT 'Untitled',
  `disable_login` tinyint(1) NOT NULL DEFAULT 0,
  `note` mediumtext DEFAULT NULL,
  `address` text DEFAULT NULL,
  `alternative_address` text DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `alternative_phone` varchar(20) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `ssn` varchar(20) DEFAULT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `sticky_note` mediumtext DEFAULT NULL,
  `skype` text DEFAULT NULL,
  `language` varchar(50) NOT NULL,
  `enable_web_notification` tinyint(1) NOT NULL DEFAULT 1,
  `enable_email_notification` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime DEFAULT NULL,
  `last_online` datetime DEFAULT NULL,
  `requested_account_removal` tinyint(1) NOT NULL DEFAULT 0,
  `client_permissions` text DEFAULT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `tbl_users`
--

INSERT INTO `tbl_users` (`id`, `first_name`, `last_name`, `user_type`, `is_admin`, `role_id`, `email`, `password`, `image`, `status`, `message_checked_at`, `client_id`, `notification_checked_at`, `is_primary_contact`, `job_title`, `disable_login`, `note`, `address`, `alternative_address`, `phone`, `alternative_phone`, `dob`, `ssn`, `gender`, `sticky_note`, `skype`, `language`, `enable_web_notification`, `enable_email_notification`, `created_at`, `last_online`, `requested_account_removal`, `client_permissions`, `deleted`) VALUES
(1, 'Super', 'Admin', 'staff', 1, 0, 'admin@admin.com', '$2y$10$CeeD.zurCX8mveM8BMuJ4.X9aKFVz6EkV66kwv/O2DNPgoK7tm3Su', NULL, 'active', NULL, 0, NULL, 0, 'Admin', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'male', NULL, NULL, '', 1, 1, '0000-00-00 00:00:00', '2024-06-21 18:17:00', 0, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_verification`
--

CREATE TABLE `tbl_verification` (
  `id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `type` enum('invoice_payment','reset_password','verify_email','invitation') NOT NULL,
  `code` varchar(10) NOT NULL,
  `params` text NOT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_activity_logs`
--
ALTER TABLE `tbl_activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `log_for` (`log_for`,`log_for_id`),
  ADD KEY `log_for2` (`log_for2`,`log_for_id2`),
  ADD KEY `log_type` (`log_type`,`log_type_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `tbl_announcements`
--
ALTER TABLE `tbl_announcements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `tbl_article_helpful_status`
--
ALTER TABLE `tbl_article_helpful_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_attendance`
--
ALTER TABLE `tbl_attendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `checked_by` (`checked_by`);

--
-- Indexes for table `tbl_checklist_groups`
--
ALTER TABLE `tbl_checklist_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_checklist_items`
--
ALTER TABLE `tbl_checklist_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_checklist_template`
--
ALTER TABLE `tbl_checklist_template`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_ci_sessions`
--
ALTER TABLE `tbl_ci_sessions`
  ADD KEY `ci_sessions_timestamp` (`timestamp`);

--
-- Indexes for table `tbl_clients`
--
ALTER TABLE `tbl_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner_id` (`owner_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `lead_source_id` (`lead_source_id`),
  ADD KEY `is_lead` (`is_lead`);

--
-- Indexes for table `tbl_client_groups`
--
ALTER TABLE `tbl_client_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_company`
--
ALTER TABLE `tbl_company`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_contracts`
--
ALTER TABLE `tbl_contracts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_contract_items`
--
ALTER TABLE `tbl_contract_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_contract_templates`
--
ALTER TABLE `tbl_contract_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_custom_fields`
--
ALTER TABLE `tbl_custom_fields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `related_to` (`related_to`),
  ADD KEY `field_type` (`field_type`);

--
-- Indexes for table `tbl_custom_field_values`
--
ALTER TABLE `tbl_custom_field_values`
  ADD PRIMARY KEY (`id`),
  ADD KEY `related_to_type` (`related_to_type`),
  ADD KEY `related_to_id` (`related_to_id`),
  ADD KEY `custom_field_id` (`custom_field_id`);

--
-- Indexes for table `tbl_custom_widgets`
--
ALTER TABLE `tbl_custom_widgets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tbl_dashboards`
--
ALTER TABLE `tbl_dashboards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tbl_email_templates`
--
ALTER TABLE `tbl_email_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_estimates`
--
ALTER TABLE `tbl_estimates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_estimate_comments`
--
ALTER TABLE `tbl_estimate_comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_estimate_forms`
--
ALTER TABLE `tbl_estimate_forms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_estimate_items`
--
ALTER TABLE `tbl_estimate_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_estimate_requests`
--
ALTER TABLE `tbl_estimate_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_events`
--
ALTER TABLE `tbl_events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `task_id` (`task_id`),
  ADD KEY `recurring` (`recurring`),
  ADD KEY `start_date` (`start_date`),
  ADD KEY `end_date` (`end_date`);

--
-- Indexes for table `tbl_event_tracker`
--
ALTER TABLE `tbl_event_tracker`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_expenses`
--
ALTER TABLE `tbl_expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `tbl_expense_categories`
--
ALTER TABLE `tbl_expense_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_file_category`
--
ALTER TABLE `tbl_file_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_folders`
--
ALTER TABLE `tbl_folders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_general_files`
--
ALTER TABLE `tbl_general_files`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_help_articles`
--
ALTER TABLE `tbl_help_articles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_help_categories`
--
ALTER TABLE `tbl_help_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_invoices`
--
ALTER TABLE `tbl_invoices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status` (`status`),
  ADD KEY `due_date` (`due_date`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `tbl_invoice_items`
--
ALTER TABLE `tbl_invoice_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_invoice_payments`
--
ALTER TABLE `tbl_invoice_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `id_2` (`id`);

--
-- Indexes for table `tbl_items`
--
ALTER TABLE `tbl_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_item_categories`
--
ALTER TABLE `tbl_item_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_labels`
--
ALTER TABLE `tbl_labels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `context` (`context`);

--
-- Indexes for table `tbl_leads`
--
ALTER TABLE `tbl_leads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_lead_source`
--
ALTER TABLE `tbl_lead_source`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_lead_status`
--
ALTER TABLE `tbl_lead_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_leave_applications`
--
ALTER TABLE `tbl_leave_applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `leave_type_id` (`leave_type_id`),
  ADD KEY `user_id` (`applicant_id`),
  ADD KEY `checked_by` (`checked_by`);

--
-- Indexes for table `tbl_leave_types`
--
ALTER TABLE `tbl_leave_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_likes`
--
ALTER TABLE `tbl_likes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_messages`
--
ALTER TABLE `tbl_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `message_from` (`from_user_id`),
  ADD KEY `message_to` (`to_user_id`);

--
-- Indexes for table `tbl_milestones`
--
ALTER TABLE `tbl_milestones`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_notes`
--
ALTER TABLE `tbl_notes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_notifications`
--
ALTER TABLE `tbl_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tbl_notification_settings`
--
ALTER TABLE `tbl_notification_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event` (`event`);

--
-- Indexes for table `tbl_orders`
--
ALTER TABLE `tbl_orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_order_items`
--
ALTER TABLE `tbl_order_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_order_status`
--
ALTER TABLE `tbl_order_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_pages`
--
ALTER TABLE `tbl_pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_payment_methods`
--
ALTER TABLE `tbl_payment_methods`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_paypal_ipn`
--
ALTER TABLE `tbl_paypal_ipn`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_pin_comments`
--
ALTER TABLE `tbl_pin_comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_posts`
--
ALTER TABLE `tbl_posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_projects`
--
ALTER TABLE `tbl_projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `status_id` (`status_id`);

--
-- Indexes for table `tbl_project_comments`
--
ALTER TABLE `tbl_project_comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_project_files`
--
ALTER TABLE `tbl_project_files`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_project_members`
--
ALTER TABLE `tbl_project_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `tbl_project_settings`
--
ALTER TABLE `tbl_project_settings`
  ADD UNIQUE KEY `unique_index` (`project_id`,`setting_name`);

--
-- Indexes for table `tbl_project_status`
--
ALTER TABLE `tbl_project_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_project_time`
--
ALTER TABLE `tbl_project_time`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_proposals`
--
ALTER TABLE `tbl_proposals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_proposal_comments`
--
ALTER TABLE `tbl_proposal_comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_proposal_items`
--
ALTER TABLE `tbl_proposal_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_proposal_templates`
--
ALTER TABLE `tbl_proposal_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_roles`
--
ALTER TABLE `tbl_roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_settings`
--
ALTER TABLE `tbl_settings`
  ADD UNIQUE KEY `setting_name` (`setting_name`);

--
-- Indexes for table `tbl_social_links`
--
ALTER TABLE `tbl_social_links`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_stripe_ipn`
--
ALTER TABLE `tbl_stripe_ipn`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_subscriptions`
--
ALTER TABLE `tbl_subscriptions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_subscription_items`
--
ALTER TABLE `tbl_subscription_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_tasks`
--
ALTER TABLE `tbl_tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status_id` (`status_id`),
  ADD KEY `priority_id` (`priority_id`),
  ADD KEY `sort` (`sort`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `milestone_id` (`milestone_id`),
  ADD KEY `assigned_to` (`assigned_to`),
  ADD KEY `ticket_id` (`ticket_id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `invoice_id` (`invoice_id`),
  ADD KEY `estimate_id` (`estimate_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `contract_id` (`contract_id`),
  ADD KEY `proposal_id` (`proposal_id`),
  ADD KEY `subscription_id` (`subscription_id`),
  ADD KEY `expense_id` (`expense_id`),
  ADD KEY `lead_id` (`lead_id`);

--
-- Indexes for table `tbl_task_priority`
--
ALTER TABLE `tbl_task_priority`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_task_status`
--
ALTER TABLE `tbl_task_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_taxes`
--
ALTER TABLE `tbl_taxes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_team`
--
ALTER TABLE `tbl_team`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_team_member_job_info`
--
ALTER TABLE `tbl_team_member_job_info`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tbl_tickets`
--
ALTER TABLE `tbl_tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `ticket_type_id` (`ticket_type_id`),
  ADD KEY `assigned_to` (`assigned_to`);

--
-- Indexes for table `tbl_ticket_comments`
--
ALTER TABLE `tbl_ticket_comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_ticket_templates`
--
ALTER TABLE `tbl_ticket_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_ticket_types`
--
ALTER TABLE `tbl_ticket_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_to_do`
--
ALTER TABLE `tbl_to_do`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `tbl_users`
--
ALTER TABLE `tbl_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_type` (`user_type`),
  ADD KEY `email` (`email`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `deleted` (`deleted`);

--
-- Indexes for table `tbl_verification`
--
ALTER TABLE `tbl_verification`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_activity_logs`
--
ALTER TABLE `tbl_activity_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_announcements`
--
ALTER TABLE `tbl_announcements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_article_helpful_status`
--
ALTER TABLE `tbl_article_helpful_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_attendance`
--
ALTER TABLE `tbl_attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_checklist_groups`
--
ALTER TABLE `tbl_checklist_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_checklist_items`
--
ALTER TABLE `tbl_checklist_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_checklist_template`
--
ALTER TABLE `tbl_checklist_template`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_clients`
--
ALTER TABLE `tbl_clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_client_groups`
--
ALTER TABLE `tbl_client_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_company`
--
ALTER TABLE `tbl_company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_contracts`
--
ALTER TABLE `tbl_contracts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_contract_items`
--
ALTER TABLE `tbl_contract_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_contract_templates`
--
ALTER TABLE `tbl_contract_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_custom_fields`
--
ALTER TABLE `tbl_custom_fields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_custom_field_values`
--
ALTER TABLE `tbl_custom_field_values`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_custom_widgets`
--
ALTER TABLE `tbl_custom_widgets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_dashboards`
--
ALTER TABLE `tbl_dashboards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_email_templates`
--
ALTER TABLE `tbl_email_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `tbl_estimates`
--
ALTER TABLE `tbl_estimates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_estimate_comments`
--
ALTER TABLE `tbl_estimate_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_estimate_forms`
--
ALTER TABLE `tbl_estimate_forms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_estimate_items`
--
ALTER TABLE `tbl_estimate_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_estimate_requests`
--
ALTER TABLE `tbl_estimate_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_events`
--
ALTER TABLE `tbl_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_event_tracker`
--
ALTER TABLE `tbl_event_tracker`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_expenses`
--
ALTER TABLE `tbl_expenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_expense_categories`
--
ALTER TABLE `tbl_expense_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_file_category`
--
ALTER TABLE `tbl_file_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_folders`
--
ALTER TABLE `tbl_folders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_general_files`
--
ALTER TABLE `tbl_general_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_help_articles`
--
ALTER TABLE `tbl_help_articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_help_categories`
--
ALTER TABLE `tbl_help_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_invoices`
--
ALTER TABLE `tbl_invoices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_invoice_items`
--
ALTER TABLE `tbl_invoice_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_invoice_payments`
--
ALTER TABLE `tbl_invoice_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_items`
--
ALTER TABLE `tbl_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_item_categories`
--
ALTER TABLE `tbl_item_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_labels`
--
ALTER TABLE `tbl_labels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_leads`
--
ALTER TABLE `tbl_leads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_lead_source`
--
ALTER TABLE `tbl_lead_source`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tbl_lead_status`
--
ALTER TABLE `tbl_lead_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tbl_leave_applications`
--
ALTER TABLE `tbl_leave_applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_leave_types`
--
ALTER TABLE `tbl_leave_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_likes`
--
ALTER TABLE `tbl_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_messages`
--
ALTER TABLE `tbl_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_milestones`
--
ALTER TABLE `tbl_milestones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_notes`
--
ALTER TABLE `tbl_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_notifications`
--
ALTER TABLE `tbl_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_notification_settings`
--
ALTER TABLE `tbl_notification_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `tbl_orders`
--
ALTER TABLE `tbl_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_order_items`
--
ALTER TABLE `tbl_order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_order_status`
--
ALTER TABLE `tbl_order_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_pages`
--
ALTER TABLE `tbl_pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_payment_methods`
--
ALTER TABLE `tbl_payment_methods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_paypal_ipn`
--
ALTER TABLE `tbl_paypal_ipn`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_pin_comments`
--
ALTER TABLE `tbl_pin_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_posts`
--
ALTER TABLE `tbl_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_projects`
--
ALTER TABLE `tbl_projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_project_comments`
--
ALTER TABLE `tbl_project_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_project_files`
--
ALTER TABLE `tbl_project_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_project_members`
--
ALTER TABLE `tbl_project_members`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_project_status`
--
ALTER TABLE `tbl_project_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_project_time`
--
ALTER TABLE `tbl_project_time`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_proposals`
--
ALTER TABLE `tbl_proposals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_proposal_comments`
--
ALTER TABLE `tbl_proposal_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_proposal_items`
--
ALTER TABLE `tbl_proposal_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_proposal_templates`
--
ALTER TABLE `tbl_proposal_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_roles`
--
ALTER TABLE `tbl_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_stripe_ipn`
--
ALTER TABLE `tbl_stripe_ipn`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_subscriptions`
--
ALTER TABLE `tbl_subscriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_subscription_items`
--
ALTER TABLE `tbl_subscription_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_tasks`
--
ALTER TABLE `tbl_tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_task_priority`
--
ALTER TABLE `tbl_task_priority`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbl_task_status`
--
ALTER TABLE `tbl_task_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tbl_taxes`
--
ALTER TABLE `tbl_taxes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_team`
--
ALTER TABLE `tbl_team`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_team_member_job_info`
--
ALTER TABLE `tbl_team_member_job_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_tickets`
--
ALTER TABLE `tbl_tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_ticket_comments`
--
ALTER TABLE `tbl_ticket_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_ticket_templates`
--
ALTER TABLE `tbl_ticket_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_ticket_types`
--
ALTER TABLE `tbl_ticket_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_to_do`
--
ALTER TABLE `tbl_to_do`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_users`
--
ALTER TABLE `tbl_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_verification`
--
ALTER TABLE `tbl_verification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
