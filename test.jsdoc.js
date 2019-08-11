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
