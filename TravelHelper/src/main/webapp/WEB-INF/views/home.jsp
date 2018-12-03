<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Include in <head> to load fonts from Google -->
<link href='https://fonts.googleapis.com/css?family=Source+Sans+Pro:900' rel='stylesheet' type='text/css'>




<!--Main container-->


	<div class="video-background">	
	    <div class="video-foreground">	
	     <iframe src="https://www.youtube.com/embed/
			8Z7KanIbh14?modestbranding=1&amp;rel=0&amp;showinfo=0&amp;autoplay=1&loop=1;playlist=8Z7KanIbh14"
			style="position: absolute; width: 100%; height: 100%; left: 0"
			width="640" height="360" frameborder="0"
			allow="autoplay; encrypted-media" allowfullscreen></iframe>
							
		<!-- <iframe src="https://www.youtube.com/embed/
	     	8Z7KanIbh14?modestbranding=1&amp;rel=0&amp;showinfo=0&amp;autoplay=1&amp;vq=hd720&loop=100;playlist=8Z7KanIbh14"
			style="position: absolute; width: 100%; height: 100%; left: 0"
			width="640" height="360" frameborder="0"
			allow="autoplay; encrypted-media" allowfullscreen></iframe> -->	
	    </div>	
	</div>
 
 
 <!-- 배너 -->
<link href='https://fonts.googleapis.com/css?family=Playfair+Display:400italic' rel='stylesheet' type='text/css'>

<!-- Typography -->
	<div class="sos">
	  <h1 class="sos-r1">Travel <span class="sos-prep"> and </span> Helper</h1>
	</div>
	
	<style type="text/css">
		.sos {
		  color: #f1cf63;
		  background-color: #343434;
		  text-align: center;
		  font-family: Source Sans Pro, sans-serif;
		  line-height: 3em;
		  padding-top: 1em;
		  padding-bottom: 2em;
		}
		
		.sos-r1 {
		  font-size: 10em;
		  font-weight: 900;
		  line-height: 1.1em;
		}
		
		.sos-prep {
		  font-family: Playfair Display;
		  font-weight: 400;
		  font-style: italic;
		  font-size: 0.5em;
		  vertical-align: middle;
		  margin-top: -0.4em;
		  display: inline-block;
		}
	</style>

 
 
 
<div class="container">


	<br>
	<div class="row">
		<!-- 1행 1열의 사진 -->

		<div class="col-md-5">
			<div class="view overlay z-depth-1-half">
				<img src="resources/images/1.jpg" class="card-img-top" alt="">
					<div class="mask rgba-white-light"></div>
			</div>
		</div>

		<!-- 1열 2행의 글 내용 -->
		<div class="col-md-5">
		
			<h2  style="font-family: Source Sans Pro, sans-serif;color: white;">WEATHER INFO</h2>
			<hr>
			<p style="color: white;">${weatherInfo}</p>
			<a href="#" class="btn btn-unique"> Click Me!</a>
		</div>
	</div>



	<br>
	<div class="row">

		<!--Grid column-->
		<div class="col-lg-4 col-md-12">
			<div class="card">
				<div class="view overlay">
					<img src="resources/images/9.jpg" class="card-img-top" alt="">
					<a href="#">
						<div class="mask rgba-white-slight"></div>
					</a>
				</div>
				<div class="card-body">
					<h4 class="card-title">Card title</h4>
					<p class="card-text">Some quick example text to build on the
						card title and make up the bulk of the card's content.</p>
					<a href="#!" class="btn btn-unique">Button</a>
				</div>
			</div>

		</div>

		<div class="col-lg-4 col-md-6">

			<div class="card">
				<div class="view overlay">
					<img src="resources/images/2.jpg" class="card-img-top" alt="">
					<a href="#">
						<div class="mask rgba-white-slight"></div>
					</a>
				</div>
				<div class="card-body">
					<h4 class="card-title">Card title</h4>
					<p class="card-text">Some quick example text to build on the
						card title and make up the bulk of the card's content.</p>
					<a href="#" class="btn btn-unique">Button</a>
				</div>
			</div>
		</div>

		<div class="col-lg-4 col-md-6">

			<div class="card">
				<div class="view overlay">
					<img src="resources/images/3.jpg" class="card-img-top" alt="">
					<a href="#">
						<div class="mask rgba-white-slight"></div>
					</a>
				</div>
				<div class="card-body">
					<h4 class="card-title">Card title</h4>
					<p class="card-text">Some quick example text to build on the
						card title and make up the bulk of the card's content.</p>
					<a href="#" class="btn btn-unique">Button</a>
				</div>
			</div>

		</div>
	</div>
</div>

</main>
<!--Main layout-->