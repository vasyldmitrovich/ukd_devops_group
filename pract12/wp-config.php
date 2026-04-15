<?php
define( 'WP_HOME', 'http://localhost:8080' );
define( 'WP_SITEURL', 'http://localhost:8080' );
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
define( 'DB_PASSWORD', 'password' );

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
define( 'AUTH_KEY',         'ymhG: ywMqSkor(TiZ-grNR4~eF=!}eo{m09@d.!r+c8b<dup/XjK3+sm[S^5(xQ' );
define( 'SECURE_AUTH_KEY',  'By]{z?Ngf|fT^^].JWpi(!E|]bGxVg2 l$~l+rg.:&^)3i r-Msdf%KGKTZ?[|P!' );
define( 'LOGGED_IN_KEY',    'jGgdhlI?<Yk8~JvI(f~ia{dMlQM9G4,~(MoAk[+meTZis.s$&9}+lvKXQKQZ.a`|' );
define( 'NONCE_KEY',        '~::rTJ:{ENd<C.0-4C!%HpSJF?55X|t~bb.%NV@7#,;w,$0@PZ+tB|x|ziA4]A<a' );
define( 'AUTH_SALT',        'us@u<-h>-5Feq+Hgr5v.rDj[v#=iM3v,)TU,1%D9xn?{vj0xG+xN 4`dX%u7EIx+' );
define( 'SECURE_AUTH_SALT', '^f:aCq12)%T_&!glK(yHv1{EPQ+<kM0@1vfUKZ&$|uH.;[AO,){)iY`D9c<If?$>' );
define( 'LOGGED_IN_SALT',   '>kr7.i8OfN6bP?DOD]aORXQgm=_pwXJ}Xl_If!B(`-^&f{bN;-JbjO7w)B&>g<Hb' );
define( 'NONCE_SALT',       'hcq*euj-<_dXVp4M5tFx_@%,C#e:~oQ@Gw,7)m2AJfDO.AnAtp$Y66,uMBidk9vw' );

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
