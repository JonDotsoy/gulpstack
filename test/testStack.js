module.exports = {

  iftrue: function (test)
  {
    test.expect(1);
    test.ok(true, 'is true');
    test.done();
  },

  otherTest: function (test) {
    // test.expect(30);
    test.ok(true, "this is false, of other reazon.");
    throw 'this is a error.';
    test.done();
  },

};
