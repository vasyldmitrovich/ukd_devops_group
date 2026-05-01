<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the website, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress_db' );

/** Database username */
define( 'DB_USER', 'wp_prod' );

/** Database password */
define( 'DB_PASSWORD', 'StrongPass123!' );

/** Database hostname */
define( 'DB_HOST', 'localhost' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         ';s#i:spqj}EXE4_59+H6[e(9$Gd.96vm)v)q(6?<-Y+=~R`e+Aub?tkjDr,iLb}9' );
define( 'SECURE_AUTH_KEY',  'Bwz%o%Y4x]?+VF%)^EU]%oj$4}(~k,`dmrfY##dOTS*<8qSP?]~<9Vp}H%nG0l,L' );
define( 'LOGGED_IN_KEY',    ':1^if2&b:UIH%Z,0.WcTsk343JLehg+KQD+16VA$FSc~]W|*+63fFcR]gVFroJG+' );
define( 'NONCE_KEY',        '6~mSsCy5f&-O}I5L#/KLqu+9;gpp;`Ikh,lbW;qKx7R[m%|dIAz)zx%GC{V8+:=;' );
define( 'AUTH_SALT',        'kj>7-dS&~pFaEM/6|)!m`gRW{D%3z>L<?J!R}%Kzo.t,l+{p<6]) l[VKCtL=ZBt' );
define( 'SECURE_AUTH_SALT', '1X6Fxf8*LV1!IhW-hcx&8vRjaGF3=f;@by+yG1CP)v,ah7<.lC`3RxYt1iI=aV^6' );
define( 'LOGGED_IN_SALT',   'M<?%o%<CGpMFXfZ,1GweB;9uxBY,t<-tI],4wHVYYN;2#[(6ethZpSrvYdi@tXy?' );
define( 'NONCE_SALT',       '3p! 7oi(4`S>M8 /BFl!ATQ{OT69E|izX4icVqKkL@;2;]a*6(`qN{O8qT5Ye=wb' );

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 *
 * At the installation time, database tables are created with the specified prefix.
 * Changing this value after WordPress is installed will make your site think
 * it has not been installed.
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/#table-prefix
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://developer.wordpress.org/advanced-administration/debug/debug-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';

define('WP_HOME','http://localhost');
define('WP_SITEURL','http://localhost');

