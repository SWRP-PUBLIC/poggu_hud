let isShowed = false
$(function () {

	window.addEventListener('message', function (event) {
		switch (event.data.action) {
			case 'setJob':
				$('.job-text').text(event.data.data)
				break
			case 'setMoney':
				$('#cash').text('$ ' + event.data.cash)
				$('#bank').text('$ ' + event.data.bank)
				console.log(event.data.black_money)
				if(typeof event.data.black_money !== 'undefined') {
					$('#black_money_item').show()
					$('#black_money').text('$ ' + event.data.black_money)
				} else {
					console.log('haha')
					$('#black_money_item').fadeOut()
				}
				if (typeof event.data.society !== 'undefined') {
					$('#society_item').fadeIn()
					$('#society').text('$ ' + event.data.society)
				} else {
					$('#society_item').hide()
				}
				break
			case 'showAdvanced':
				if (!isShowed) {
					isShowed = true
					$('.container').animate({
						right: "+=105px"
					}, 600, () => {
						setTimeout(() => {
							$('.container').animate({
								right: "-=105px"
							}, 600)
							isShowed = false
						}, 6000);
					})
				}
				break
		}
	})
})