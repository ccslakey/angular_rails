// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require angular/angular
//= require_tree .


var AccountApp = angular.module("AccountApp", [])

// just add this!! 
AccountApp.config(["$httpProvider", function ($httpProvider) {
    $httpProvider.
        defaults.headers.common["X-CSRF"] = $("meta[name=csrf-token]").attr("content");
}])

AccountApp.controller("MainCtrl", function($scope, $http){
	$scope.greeting = "Hellowwwwww";

	$scope.current_user = null;

	$scope.reset_token = function(){
	 alert("hi");
	}

	$http.get("/account.json").
		success(function(data){
			$scope.current_user = data;
		});
});