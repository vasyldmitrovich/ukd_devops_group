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
define( 'DB_USER', 'wp_user' );

/** Database password */
define( 'DB_PASSWORD', 'password123' );

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
define( 'AUTH_KEY',         'T&9-?w8&3Bd.%b3Q>.beo*pe}f#xmK-!G}bsP`I}Baqr!2od)e,HoM%<K<R |l_.' );
define( 'SECURE_AUTH_KEY',  'b9m@/&(}yrxG!+vr.V)% Qt|kT|Fz=.OL%|o]Mc{sO;m_A&e*TR?Qbx&u]/j(2H*' );
define( 'LOGGED_IN_KEY',    '?:,h@^ Q$8hmyA:rd11H!^4p3-0`nGpx-(yQe&L}6VQNqj^3]jb)G:be;hTna.s%' );
define( 'NONCE_KEY',        'm247du~/YUul:? ;<bD4Ee:3:Wu6G5W|xncXm8R?PHs>Neg/n)IfT8lEy92DTr$l' );
define( 'AUTH_SALT',        'c}}_qsks@keH4%`3GBHS$U2U-`D>Z`_rP}?K:cfj3 FO;AZ>;0P)c5H_Eq@h6Ymg' );
define( 'SECURE_AUTH_SALT', 'r*]m06M(=qz;x6r8tytiiK%nRQV8Q.(,:$OU}J;Rc!F4X}v /z1KvM#IS1#EnBD:' );
define( 'LOGGED_IN_SALT',   '$CZ1XnYyau?U1GzJu$W$&MzW:o_>7ji]}#r6e:`jvprxL@ !txI)k]]^|W=nwT:v' );
define( 'NONCE_SALT',       '+F!B +btxwTY8y|,p,=,Ob)HC),ylD^R{|e]YiV&~Fv`O}ve1)9@@DD}pF1d%kzt' );

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
