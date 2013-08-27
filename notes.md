# Responsive Design

## Intro

Break the wrist and walk away.  Who is this?  Where is he?  Why is he there?

This is me and design.  I want to be a designer so bad.  I want to build beatiful sites.  I want so badly to be able to create and build.  I don't just want to code, I want to be an artist.  A designer.  I work for a UI company.  Everything that I live and breathe is UI.

The sad truth of the matter is that I am not a designer, and no amount of trying or wanting is going to make me one.  Just like Kip though, I refuse to give up on my dream.  It does mean though, that I need help.  I need all the help I can get.  Just like Kip though, Even with all the help in the world, I still will never be able to build truly beautiful and original sites.  I will never be a cage fighter.

And that's OK.  If high school drilled one thing into us, it's that you have to know who you are and fully support that person.  That and how to make a beer bong.

How many of you find yourselves in the same boat as me?  How many of you don't really care about pixels, but still love UI, and at the end of the day, you just want to get it done.  How many of you work with a designer?

I'm going to throw some names up on the screen and I want you to raise your hand if you recognize any of them.

These names are very well known in web design circles.  These people are designers.  If you were to go to a frontend conference like Smashing Conference or FrontTrends, these people need no introduction.  They have and are shaping how design for the web.

We are not in design circles though.  By and large we are not designing applications, we are building them.  There is a massive difference.  Not to say that these folks don't build applications, but we are, at the end of the day, paid to deliver functionality, not pixels.

A lot of what I will talk about today is fundamental in the design community.  We as engineers and not designers do need to understand it though, because it will change the way that you build apps.

So here go.

Responsive Design.  Bootstrap.  All we need to do is drop HTML5 into this title and we could just drop the mic and walk away right?  These words are more than just concepts and libraries.  They carry their own connotations and associations.

Responsive Design is fairly broad in traditional meaning, but to us as engineers, it means "Build it once and it magically just works everywhere".  Bootstrap is a CSS framework (with some JavaScript components), but to us it means "Instant App".

Both of these terms are acurrate in the feeling they invoke.  They have, in fact, earned these reputations.

## Responsive Design

Responsive Design was of course coined by a designer named Ethan Marcotte in his 2008 article on a List Apart. He then penned a book by the same name.  However, most people forget that it was his presentation called "A Dao Of Flexibility" that officially propelled "Responsive Design" into the spotlight and really began the revolution.  

Responsive design is really built on 3 pillars.  Fluid grids, fluid media and media queries.  We're going to talk about all 3 of these things today, because Bootstrap handles all of them for you at some level.

However, it's important to note that respnsive design is only the very tip of a much larger concept known as the "adaptive web experience".

In his presentation at Smashing Conference, Brad Frost displays this as an iceburg.  Responsive Design is just the tip.  The body of it encompasses much much more.  To stop at the simple presentation of material would be criminal.  Mobile devices offer us so much more than just a standard web experience.  A full adapative web experience would take full advantage of the device.

Lets get back to Ethan for a minute.

In his presentation, Ethan shares his thought process and how he arrived at the solution to a fundamental problem.  It all starts with print design and how that translates to the web.

### Print Vs Web

The web was originally designed to display static documents that linked to one another.  So that if one document referenced another, you wouldn't have to go and find that other document, but rather clicking simply on the documents name would take you right to it. 

Being that the web was designed for online "print", the constructs that we use to replicate online print are what HTML and CSS provide.  For a long time, we have been replicating print strategies on the web.  For example a grid system.  rows and columns.  Print uses this same strategy.  Articles and images are laid out in a grid.  This makes content legible and allows it to flow down the page.

By and large, print is perfectly suited for the web.  Except for one MAJOR difference.  You can't resize a newspaper.

Originally we only had to worry about two form factors.  The desktop.  And the laptop.  What we did to deal with that was define a "minimum supported width".  I remember back in the day when we stopped supporting folks on 800.600 monitors.  It felt so good to be able to say that we expect that your screen will be at least 1024 pixels wide.  At that time, nobody could have imagined that you would EVER need to see the web at a resolution smaller than that.  BTW - a common reslotion size for today's phones is 320.480.

Ethan talks about how he would go about translating a print mockup to the web.  The first problem that you face is text sizing.  We as engineers typically don't think about text size.  Because why.  However, it's important to know something about Text Sie for the sake of responsive design.

### Em's Vs Pixels

Lets talk a bit about em's and pixels.  Text can be sized in a variety of ways.  The two most common ways are in pixels and em's.  A pixel needs no explanation, unless you really want to split hairs and then I highly recommend you read PPK's article "a pixel is not a pixel".

An em is another story.  Em means the size of an "M".  Or - in plain english - the size of the text as specified by the browser.  This is something we usually don't think about.  How big is the text?  Who decides?  The browser does if you don't tell it.  What's worse is that the user can actually override this.  What this means is that you have no idea what a user's styles will be when they load your page.  You can count on nothing.

Let's look at how bootstrap handles this.

## Bootstrap Basics

### Typography

In this example, you see the various headings and a paragraph tag.  Notice that there is left padding.  If I shrink this down, you will see that the text is centered in the container.

If I take bootstrap off, you see the changes.  The text is ugly for one, with the default browser style.  Also notice that the size of the text is changed.  If I change the overall browser font-size, you can see that the browser resizes all the text.  Did I really just ask it to do that?  I said that I wanted the text size on the page to be 20px and it resized everything.  Including my headings.  And this is only for Chrome.  If we were to use a different browser, we would get different results sans bootstrap.

At its core, Bootstrap includes normalize.css.  This is a library that does a "reset" on your CSS.  In other words, it provides a baseline of font, margin and padding that assures your simple HTML will look the same in all browsers, as well as fix some basic browser bugs.  Note that in later browsers, normalize is almost unncecessary.  That's encouraging.

### Media Queries

We also need to talk briefly about Media Queries.  Media queries are one of the 3 core pieces of the responsive design puzzle, but you can't really understand the other two if you don't get this one.

A Media Query is defined by MDN in this rather verbose but precise description.  I overly simplify it to just this.

Media queries can be used to load in entire stylesheets, by they are more commonly found in a stylesheet loaded by the browser.

As you can see from this fancy pants media query for a tv, Media Queries consist of two parts - a media type and a size rule that can have multiple conditions.  Media Queries can get unwieldy.  Most often, you will not see the media type.  Usually responsive design is done based on the size of the screen, not the media type that the device reports itself to be.  A device may lie about itself, but it can't lie about it's screensize.

Let's take a look at a simple one in action.  

This media query says that when the width of the screen gets below 700 pixels, change the color of the text to "gentleman's pink" - otherwise known as Salmon.  You can apply any CSS like this, including transitions - where supported.

I could fade this element out by adding a transition.  I can also flip the element upside down using a CSS 3 transform.

.sample-query {
  transition:all 1s
}

@media (max-width: 700px) {
  .sample-query {
    -webkit-transform: rotate(-180deg);
   opacity: 0;
  }
}

OK - enough fun with useless CSS and media queries.

We're almost ready to get into Bootstrap itself and talk about how you use it to build gorgeous responsive sites.  One last word of caution: Bootstrap is not magic.  It does not cure cancer.  Only Chuck Norris's tears do that.  You are not going to drop this onto your site and magically have a cross platform application that works on every device and is future proof.  In fact, you are going to have to do a fair bit of extra work on top of what Bootstrap gives you out of the box to be fully responsive.  And remember that responsive design is only the tip of the iceberg.

Appropriate disclaimers in place, lets dig in.

## Bootstrap 3

Before you do ANY bootstrapping, you need to add a meta tag to your page.  All of the bootstrap in the world won't do you a lick of good if you leave this tag out.  What does this tag do?

When Apple first came up with a phone that could actually browser the internet, they had a huge problem to solve.  Namely, how on earth do you browse the internet on such a tiny screen?  The solution?  Pan and zoom.  Because the iPhone did touch, did multi-touch and id it SO well, Apple decided to have the browser treat pages as if it were a desktop browser.  By default, the device will zoom all the way out on any page so that you can see the entire site.  It's then up to you to double tab to zoom in.  This was an enormously effective strategy, and as it turns out, people don't mind tapping and zooming.  But we can do better.

## Mobile First

Bootstrap has always had an emphasis on Mobile.  However, up until version 3, mobile was a sort of "bolt-on" addition.  In fact, the responsive styles were in a separate stylesheet that you could choose not to include.

As of Bootstrap 3, this has completely changed.

Bootstrap is now mobile first.  This means that you are expected to be building a mobile app first, and considerations are taken into account to accomodate larger screens, not the other way around as it has been for quite some time.

This means that there has been a fundamental change in the grid system.  If you knew the grid system in Bootstrap 2, it's going to require you to re-aquaint yourself with the new "mobile first" grid system.

### Containers And Rows

Bootstrap is still comprised of a container that - well - "contains" rows.  Each row contains 1 - 12 columns that behave differently depending on the CSS class you choose to apply.  You used to be able to choose between a fixed and fluid container.  Now there is only the fluid container.  The container centers the content on the page, providing equal spacing on the left and the right.  Containers have a max width set at various breakpoints inside of Bootstrap.

You can resize this slide to see the container change size at different points.  Notice that the grid has a max width of 1140 pixels.  Once the width is reduced below 1200px, the grid width is reduced to 940px.  One we break 992 pixels, the container drops to a max width of 720.  The padding is always 15 pixels on the top and bottom of a container and margin is set to auto - perfectly centering the container on the page.

The breakpoints are important to know, because they are going to let you know at which point you grid is going to change it's layout, based on which column types you choose.  That's a bit confusing, so let's just look at the media queries that bootstrap has first.

Bootstrap divides up the layout into 4 categories, phones - or anything 400 pixels or larger. Tablets, which are 768 pixels or larger, medium sized devices - enormous tablets or desktops, and large devices, like giant cinema displays.

Based on these media queries, Bootstrap 3 provides you with 4 different types of columns.

## col-xs

The first type is based on the first media query and is target at phones.  These columns never stack or break.  They are always horizontal and will continue to collapse as much as the viewport does.

## col-sm

The second type is the the small column, abbreviated <code>col-sm</code>.  It stays horizontal at anything above 768px and breaks below that to a stacked layout.

## col-md

The medium column is stacked at anything below 992px, and is intended for a smaller desktop layout.

## col-lg

The last type is the <code>col-lg</code> column, which is stacked below 1200px.  On really big screens it's horizontal, but stacked everywhere else.

So why do we need for column types?  Didn't the previous 1 reponsive column type cut it?  It all boils down to choice.  On their own, each of these columns types relatively identical in it's behaviour (except the xs columns).  You get it below a certain resolution and it stacks.  The answer is really choice.

This gives you control of exactly how your layout behaves at the 4 major decision points as defined by Bootstrap.  This can be seen in the following example where we combine different column definitions so that our layout appears differently at certain breakpoints.

Bootstrap offers some additional classes to help you with precise positioning.  You can pad a column left by a specified number of columns using an offset.

Grids also allow you to push and pull columns.  This allows you to re-order the columns based on their class, not their position in the DOM.  On first glance, this might seem like a bad idea, but again, this all about choice.  It allows you to reorder your content based on the viewport size.  You may want to do this in the case that you have certain content that is important and gets pushed below the fold on smaller screens.  For example, you have have a 2 column layout on desktop and want a very important image on the right.  However, on mobile, you want it to stack on top of the text because it's more important.  You shouldn't have to be forced to put it on the left for desktop just to acheive a higher stack position on mobile.

Pushing a column moves it right, and pulling it moves it left.

## Responsive Media

### Images

The last thing for us to discuss in terms of the three pieces of responsive design is responsive media.  Generally speaking, this refers to images, but really goes beyond that as we will see here in a minute.  However, images themselves are a big enough challenge, so lets address that first.  Lets look at the way an image behaves on the web.  Usually your image has a fixed size.  Let's go back to our our cute kitty picture.

Hopefully you are telling the browser the size of your images.  Otherwise the browser has no way of knowing and can't reserve a spot for it.  This will cause your layout to jump.

Have a look at the kitty image which has a fixed size of 500 by 500 pixels.  In this example, I have added a fixed height and width inline on the element.  As a general rule of thumb, your images should have a specified width.  As it turns out, making images fluid is super easy.  All you have to do is add a width of 100% and set the height to auto.  Done.  Bootstrap does this for you by use of the img-responsive tag.  This is another change from Bootstrap 2.  All images used to be responsive when the responsive css was added.  Now you get to toggle that on and off with just a class.

### Video

Media doesn't just stop at images though.  And here is where things get tough.  

