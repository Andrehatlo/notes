# Responsive CSS

Links:

https://labs.jensimmons.com/

### Percentage to scale based on ViewPort

```scss
body {
  width: 100vh; // 100%
  width: 50vh; // 50%
}

// Scales down based on VP size
img {
  max-width: 100%;
}
```

### Intendric ratio to create scalable blocks:

```scss
// 2:1 Ratio
.container {
  position: relative;
  height: 0;
  padding-bottom: 50%;
}

// 4:1 Ratio
.container {
  position: relative;
  height: 0;
  padding-bottom: 25%;
}
```

### Media queries

Best practise:
- Use width or max/min-width
- Small Rez first (more logical - build up vs tear down)


```scss
@media (min-width: 600px) {
  /* styles for 600px and up here */
}s
@media (max-width: 38em) {
  /* styles for 38em and up here */
}
```

#### Breakpoints:

1. Find out where your layout breaks when scaling.
2. Add query to improve layout

Use the media query bookmarklet by @robtarr to determine what media queries are being fired, and show the width and height of your browser as you scale the view port.
 [Download it here](https://github.com/sparkbox/mediaQueryBookmarklet).

Example:

If your layout breaks (text wraps around image) when the browser width is at 40em:

```scss
@media (min-width: 40em) {
  img {
    width: 60%;
    margin-left: 5%;
  }
}
```

This will make sure when the browser is below 40em that the image is scaled down to make the layout fluid.

## CONSIDER THIS

### Touch Taret Area

Most devices are controlled with the thumb rather than the mouse pointer.
How can we create a layout that works better?

- Apple recommends minimum 44px X 44px
- Using padding instead of margin (will increase touch area)

### Hover States

- Dont hide content behind `:hover`.
- Consider using modernizr

```scss
a {
  /* standard styles */
}

.no-touch a:hover {
  /* :hover styles */
}
```

In the case of hover navigation (dropdown shows on hover).
- Creates problems for touch devices
- A click is as easy as a hover

### Contrast

- Try your site outside in the sun
- Try your site in the bed when its dark
- Take it with you

### Readabilty

- Small screen != Small type
- Consider increasing font size

## RWD PROCESS (Responsive Web Development Process)

### Most devs do:

Deliver a better product than the last

### A better mindset:

Deliverables that best serves the organisation and prioritisation of content and function across multiple resolutions.

### Deliverables:

- Research deliverables
  - Brand analysis, competitor analysis, requirements gathering, interviews
  - TLDR: A good investigation of their site, what is working, what is not
- Content deliverables
  - Content inventory, gab analysis, writing
- Priority deliverables
  - information architecture, wireframes, experience design/mapping.
- Style deliverables
  - Layout / Typography / Colour / Texture
- Functional Deliverables
  - Templates, CMS, database migration, customisation


Research and content are very important and can take a long time.

What is a Wireframe:
- A layout of a webpage that demonstrates what interface elements will exist on key pages.
- Minimal styling
- To provide
  - A visual understanding of a page early in a project.
  - Create global and secondary navigation to ensure the terminology and structure used for the site meets user expectations.

### Content Priority Prototype

Get a direction of layout

- Takes the place of a traditional wireframe
- As much real content as you can
- Created in HTML, url delivered to client

NOTE: Don't design before you markup, markup a layout before you design.

### Style Prototype

Get a direction of style

- Like style tiles, but in browser
  - Concepts for colour, textures, styles for links etc.
- Accurate web typography
- Easy to show web interaction
- Client reviews in their browser of preference
  - Show client, make changes then and there

Example: Click this [Link](http://sparkbox.github.io/style-prototype/)!

## Applying RWD Styles

#### The initial layout (the smallest)

Applying CSS in layers


SCSS (base.css)

```scss
@-ms-viewport {
  width: device-width;
}

@import "reset";
@import "smallest";

@media print {
  @import "print";
}
```

#### The scale layout

SCSS (mq.css)

```scss
@media (min-width: 30em) {
  @include "min-width-30em"
}

@media (min-width: 60em) {
  @include "min-width-60em"
}
```

> Include stylesheet when media query is under 30/60em


#### The final layout

SCSS (nomq.css)

```scss
@include "min-width-30em"
@include "min-width-60em"
```

The same as `mq.css` just without media queries.
- For IE, since they dont use media queries


#### How is SCSS structured?

Take a look at the following structure:

<img src="https://i.ibb.co/562XVxX/Screenshot-2019-06-04-at-14-02-24.png" alt="Screenshot-2019-06-04-at-14-02-24" border="0">

All files that begin with `_[filename].scss` are partials that you can include in your stylesheet.

`Smallest.scss` consist of everything necessary to create a simple layout.
For media query support we create files like `_min-width-36/90em.scss` that are activated when view port is X by our media queries in `mq.scss`.

## Using EM-Based Media Queries

A proportional measurement
Layout adjust based on font-size
Adheres more to the priciples of RWD

(REM is a new type - that can be as good)

## Retrofitting:

What is retrofitting?

> Finding the fastest and lowest-risk approach to creating a better experience on an existing site for users of any size screen.

#### How to do it?

A style that changes lives:

```scss
body {
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
}
```

`border-box` includes the padding and border inside the width, like it should be.

Then apply percentages where fixed pixels live with the following rule:
- target(element)/context(container) = result(percentage)

#### Retrofitting Media Queries

- Small Resolution First, Capped

Create media queries that activate a custom stylesheet for that ViewPort.

```scss
@media (max-width: 979px) {
  @import "small";
}

// Gets imported with `small` and gets laid over with additional rules
@media (min-width: 661px) and (max-width: 979px) {
  @import "medium";
}

@media (min-width: 980px) {
  @import "original";
}
```


## Client interaction:

Before a retrofitting project, evaluate the project:
- Solid UX at higher widths?
- Semantic markup?
- Can't start over?
- Immediate need?
- Real benefit for the user?

Constantly remind them of the consumer!


#### How can we use Javascript in RWD?

##### PollyFills:

A plugin that provides the tech that you (the developer) expects the browser to provide natively.

- respond.js
- css3-mediaqueries.js

#####  Wrappers:

Make MediaQueries work in old browsers.

- matchMedia.js
- Harvey
- mediaCheck

Part of the CSS Object Module:

```javascript
if (window.matchMedia(
  "(min-width: 400px)").matches) {
    /* the VP is at least 400px wide */
  }else{
    /* the VP is less than 400px wide */
  }
))
```

##### Aggressive Enhancement

- Ajax-include-pattern.js

Gives attributes to inline html elements so that the view port can be specified on the explicit element.

```html
<h2 data-after="demo-content/link.html" data-media="(min-width: 40em)" data-ajax-bound="true">
```
