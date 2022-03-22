let Trial = {
  loadHTML: function () {
    $("#main").html(
      '<p id="p1" value="hello">This is paragraph 1.</p> <button type="button" id="button1">Toggle Paragraph 1</button><br /> <p id="p2">This is paragraph 2.</p> <button type="button" id="button2">Toggle Paragraph 2</button>'
    );

    Trial.button1();
    Trial.button2();
    Trial.clickParagraph1();
    Trial.clickParagraph2();
  },

  button1: function () {
    $("#main").on("click", "#button1", function () {
      $("#p1").slideToggle(function () {
        alert("The slide toggle effect has completed.");
      });
    });
  },

  button2: function () {
    $("#main").on("click", "#button2", function () {
      $("#p2").slideToggle("slow", function () {
        alert("The slide toggle effect has completed.");
      });
    });
  },

  clickParagraph1: function () {
    $("#main").on("click", "#p1", function () {
      // alert($("p").text()); //returns value of all the paragraphs
      alert($("#p1").text() + $("#p1").attr("style") + " inline style"); //returns value of only first paragraph
    });
  },

  clickParagraph2: function () {
    $("#main").on("click", "#p2", function () {
      alert($("#p2").text() + $("#p2").attr("style") + " inline style"); //returns value of only last paragraph
    });
  },
};
