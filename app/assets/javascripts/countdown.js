$(document).ready(function(){
  function CountDown(container, time) {
    this.container = container;
    this.button = container.querySelector('.timer-button');
    this.display = container.querySelector('.timer-display');
    this.bar = container.querySelector('.timer-bar');
    this.time = time;
    this.remainingTime = this.time;
    this.elapsedTime = 0;

    this.onButtonClick = this.onButtonClick.bind(this);
    this.addEventListeners();
    this.updateDisplay();
  }

  CountDown.fn = CountDown.prototype;

  CountDown.fn.addEventListeners = function() {
    this.button.addEventListener('click', this.onButtonClick, true);
  };

  CountDown.fn.onButtonClick = function() {
    this.init();
    this.button.removeEventListener('click', this.onButtonClick, true);
  };

  CountDown.fn.updateCounters = function() {
    this.remainingTime -= 1;
    this.elapsedTime += 1;
  };

  CountDown.fn.updateDisplay = function() {
    this.display.innerText = parseInt(this.remainingTime / 60, 10) + ':' + ('0' + (this.remainingTime % 60)).substr(-2);
  };

  CountDown.fn.updateCanvasColor = function() {
    var remainingTimePercentage = this.remainingTime / this.time;
    var transition, duration;

    if (remainingTimePercentage <= 1) {
      transition = 'white-to-green';
      duration = 0.1 * this.time;
    }

    if (remainingTimePercentage <= 0.7) {
      transition = 'green-to-yellow';
      duration = 0.2 * this.time;
    }

    if (remainingTimePercentage <= 0.5) {
      transition = 'yellow-to-orange';
      duration = 0.1 * this.time;
    }

    if (remainingTimePercentage <= 0.4) {
      transition = 'orange-to-red';
      duration = 0.4 * this.time;
    }

    if (transition && duration) {
      this.container.style['-webkit-animation-duration'] = duration + 's';
      this.container.classList.add(transition);
    }
  };

  // CountDown.fn.updateBarWidth = function() {
  //   this.bar.style.width = (this.elapsedTime / this.time * 100) + '%';
  // };

  CountDown.fn.checkFinalTime = function() {
    if (this.remainingTime === 11) {
      this.display.classList.add('finishing');
    }
  };

  // change background image of canvas div
  $('.timer-button').click(function() {
    $('.canvas').addClass("spinner");
  });

  CountDown.fn.init = function() {
    var tid = setInterval(function(){
      if (this.remainingTime === 0) {
        $('.canvas').toggleClass('spinner');
        $('#myModal').modal('toggle');
        return clearInterval(tid);
      }

      this.updateCounters();
      this.updateDisplay();
      this.updateCanvasColor();
      this.checkFinalTime();
    }.bind(this), 1000);
    $('.timer-button').hide();
  };

  new CountDown(document.querySelector('.canvas'), 1500);
});
