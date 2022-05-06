let Trial = {
  buttonClick: function () {
    $("#main").on("click", "input[type='button']", function (event) {
      //here, is the list of ways how we can access the value and properties
      //we get a this which is the complete object and now we can extract any property out of it

      $("input[type='text']").val($(event.target).val());

      console.log(this.value);
      console.log(this.localName);
      console.log($(this).attr("value"));
      console.log($(this).val());
      console.log(event.currentTarget.value);
      console.log(event.currentTarget.localName);
      console.log($("input[type='button']").attr("value"));
      console.log($("input[type='button']").val());
    });
  },

  newButtonClick: function () {
    // $("#main").on("click", "#newButton", function () {
    //   if (!this.done) {
    //     //   we have created a new button so it won't be binded with the function solution bind on parent
    //     $("p").append(
    //       '<br><input type="button" value="Newly created Button" />'
    //     );
    //     this.done = true;
    //   }

    $("#newButton").click(function () {
      console.log(JSON.stringify(this)); //check console value
      console.log("this.done:" + this.done + " || !this.done:" + !this.done);
      // undefined is true because undefined implicitly converts to false , and then ! negates it.

      if (!this.done) {
        $("p").append(
          '<br><input type="button" value="Newly created Button" />'
        );
        this.done = true;
        console.log(JSON.stringify(this));
      }

      //this will disable or off all click operations on button solution done above
      //   $("#newButton").off("click");
    });
  },
};
