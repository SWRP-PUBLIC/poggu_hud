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
				$('#black_money').text('$ ' + event.data.black_money)
				if (event.data.society) {
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