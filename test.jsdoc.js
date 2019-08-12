// @abstract/@virtual

/**
 * Generic dairy product.
 * @constructor
 */
function DairyProduct() {}

/**
 * Check whether the dairy product is solid at room temperature.
 * @abstract
 * @return {boolean}
 */
DairyProduct.prototype.isSolid = function() {
    throw new Error('must be implemented by subclass!');
};

/**
 * Cool, refreshing milk.
 * @constructor
 * @augments DairyProduct
 */
function Milk() {}

/**
 * Check whether milk is solid at room temperature.
 * @return {boolean} Always returns false.
 */
Milk.prototype.isSolid = function() {
    return false;
};


// @access
/** @constructor */
function Thingy() {

    /** @access private */
    var foo = 0;

    /** @access protected */
    this._bar = 1;

    /** @access package */
    this.baz = 2;

    /** @access public */
    this.pez = 3;

}

// same as...

/** @constructor */
function OtherThingy() {

    /** @private */
    var foo = 0;

    /** @protected */
    this._bar = 1;

    /** @package */
    this.baz = 2;

    /** @public */
    this.pez = 3;

}

// @alias
Klass('trackr.CookieManager',

    /**
     * @class
     * @alias trackr.CookieManager
     * @param {Object} kv
     */
    function(kv) {
        /** The value. */
        this.value = kv;
    }

);

/** @namespace */
var Apple = {};

(function(ns) {
    /**
     * @namespace
     * @alias Apple.Core
     */
    var core = {};

    /** Documented as Apple.Core.seed */
    core.seed = function() {};

    ns.Core = core;
})(Apple);

// Documenting objectA with @alias
var objectA = (function() {

    /**
     * Documented as objectA
     * @alias objectA
     * @namespace
     */
    var x = {
        /**
         * Documented as objectA.myProperty
         * @member
         */
        myProperty: 'foo'
    };

    return x;
})();

// @async
/**
 * Download data from the specified URL.
 *
 * @async
 * @function downloadData
 * @param {string} url - The URL to download from.
 * @return {Promise<string>} The data from the URL.
 */

// @augments/@extends
/**
 * @constructor
 */
function Animal() {
    /** Is this animal alive? */
    this.alive = true;
}

/**
 * @constructor
 * @augments Animal
 * @extends Animal
 */
function Duck() {}

// @author
/**
 * @author Jane Smith <jsmith@example.com>
 */
function MyClass() {}

// @borrows
/**
 * @namespace
 * @borrows trstr as trim
 */
var util = {
    trim: trstr
};

/**
 * Remove whitespace from around a string.
 * @param {string} str
 */
function trstr(str) {
}

// @callback
/**
 * This callback is displayed as part of the Requester class.
 * @callback Requester~requestCallback
 * @param {number} responseCode
 * @param {string} responseMessage
 */

// @class/@constructor
/**
 * Creates a new Person.
 * @constructor
 * @class {Object} person
 */
function Person() {
}

// @classdesc
/**
 * This is a description of the MyClass constructor function.
 * @class
 * @classdesc This is a description of the MyClass class.
 */
function MyClass() {
}

// @constant/@const

/**
 * @constant
 * @type {string}
 * @default
 */
const RED = 'FF0000';

/** @constant {number} */
var ONE = 1;

// @constructs
var Person = makeClass(
    /** @lends Person.prototype */
    {
        /** @constructs */
        initialize: function(name) {
            this.name = name;
        },
        /** Describe me. */
        say: function(message) {
            return this.name + " says: " + message;
        }
    }
)

makeClass('Menu',
    /**
     * @constructs Menu
     * @param items
     */
    function (items) { },
    {
        /** @memberof Menu# */
        show: function(){
        }
    }
);

// @copyright
/**
 * @file This is my cool script.
 * @copyright Michael Mathews 2011
 */

// @default
/**
 *  @constant
 *  @default
 *  @default true
 */
const RED = 0xff0000;

// @deprecated
/**
 * @deprecated since version 2.0
 */
function old() {
}

// @description
/**
 * @param {number} a
 * @param {number} b
 * @returns {number}
 * @description Add two numbers.
 */
function add(a, b) {
    return a + b;
}

// @enum
/**
 * Enum for tri-state values.
 * @readonly
 * @enum {number}
 */
var triState = {
    /** The true value */
    TRUE: 1,
    FALSE: -1,
    /** @type {boolean} */
    MAYBE: true
};

// @event
/**
 * Throw a snowball.
 *
 * @fires Hurl#snowball
 */
Hurl.prototype.snowball = function() {
    /**
     * Snowball event.
     *
     * @event Hurl#snowball
     * @type {object}
     * @property {boolean} isPacked - Indicates whether the snowball is tightly packed.
     */
    this.emit('snowball', {
        isPacked: this._snowball.isPacked
    });
};

/**
 * Throw a snowball.
 *
 * @fires Hurl#snowball
 */
Hurl.prototype.snowball = function() {
    // ...
};

/**
 * Snowball event.
 *
 * @event Hurl#snowball
 * @type {object}
 * @property {boolean} isPacked - Indicates whether the snowball is tightly packed.
 */

// @example
/**
 * Solves equations of the form a * x = b
 * @example
 * // returns 2
 * globalNS.method1(5, 10);
 * @example
 * // returns 3
 * globalNS.method(5, 15);
 * @returns {Number} Returns the value of x for the equation.
 */
globalNS.method1 = function (a, b) {
    return b / a;
};
/**
 * Solves equations of the form a * x = b
 * @example <caption>Example usage of method1.</caption>
 * // returns 2
 * globalNS.method1(5, 10);
 * @returns {Number} Returns the value of x for the equation.
 */
globalNS.method1 = function (a, b) {
    return b / a;
};

// @exports
/**
 * A module that says hello!
 * @module hello/world
 */

/** Say hello. */
define(function () {

    /**
     * A module that says hello!
     * @exports hello/world
     */
    var ns = {};
});

// @external/@host
/**
 * The built in string object.
 * @external String
 * @see {@link https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String|String}
 */

/**
 * Create a ROT13-encoded version of the string. Added by the `foo` package.
 * @function external:String#rot13
 * @example
 * var greeting = new String('hello world');
 * console.log( greeting.rot13() ); // uryyb jbeyq
 */

/**
 * The jQuery plugin namespace.
 * @external "jQuery.fn"
 * @see {@link http://learn.jquery.com/plugins/|jQuery Plugins}
 */

/**
 * A jQuery plugin to make stars fly around your home page.
 * @function external:"jQuery.fn".starfairy
 */

// @file/@fileoverview/@overview
/**
 * @file Manages the configuration settings for the widget.
 * @author Rowina Sanela 
 */

// @fires/@emits
/**
 * Drink the milkshake.
 *
 * @fires Milkshake#drain
 */
Milkshake.prototype.drink = function() {
    // ...
};

// @function/@func/@method
/** @function myFunction */

// the above is the same as:
/** @function
 * @name myFunction */

// @generator
/**
 * Generate numbers in the Fibonacci sequence.
 *
 * @generator
 * @function fibonacci
 * @yields {number} The next number in the Fibonacci sequence.
 */

// @global
(function() {
    /** @global */
    var foo = 'hello foo';

    this.foo = foo;
}).apply(window);

// @implements
/**
 * Class representing a color with transparency information.
 *
 * @class
 * @implements {Color}
 */
function TransparentColor() {}

// @kind
/**
 * A constant.
 * @kind constant
 */
const asdf = 1;

define('hurler', [], function () {
    /**
     * Event reporting that a snowball has been hurled.
     *
     * @event module:hurler~snowball
     * @property {number} velocity - The snowball's velocity, in meters per second.
     */

    /**
     * Snowball-hurling module.
     *
     * @module hurler
     */
    var exports = {
        /**
         * Attack an innocent (or guilty) person with a snowball.
         *
         * @method
         * @fires module:hurler~snowball
         */
        attack: function () {
            this.emit('snowball', { velocity: 10 });
        }
    };

    return exports;
});

define('playground/monitor', [], function () {
    /**
     * Keeps an eye out for snowball-throwers.
     *
     * @module playground/monitor
     */
    var exports = {
        /**
         * Report the throwing of a snowball.
         *
         * @method
         * @param {module:hurler~event:snowball} e - A snowball event.
         * @listens module:hurler~event:snowball
         */
        reportThrowage: function (e) {
            this.log('snowball thrown: velocity ' + e.velocity);
        }
    };

    return exports;
});

// @member
/** @class */
function Data() {
    /** @member {Object} */
    this.point = {};
}

/**
 * A variable in the global namespace called 'foo'.
 * @var {number} foo
 */

/** @class */
function Data() {
    /**
     * @type {object}
     * @property {number} y This will show up as a property of `Data#point`,
     * but you cannot link to the property as {@link Data#point.y}.
     */
    this.point = {
        /**
         * The @alias and @memberof! tags force JSDoc to document the
         * property as `point.x` (rather than `x`) and to be a member of
         * `Data#`. You can link to the property as {@link Data#point.x}.
         * @alias point.x
         * @memberof! Data#
         */
        x: 0,
        y: 1
    };
}

/**
 * @constructor FormButton
 * @mixes Eventful
 */
var FormButton = function() {
    // code...
};

/** @module myModule */
/** @module {number} myModule */

