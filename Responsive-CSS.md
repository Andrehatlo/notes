# Responsive CSS

## Use percentage to scale based on ViewPort

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

## Intendric ratio to create scalable blocks:

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

## Media queries

Best practise: Use width or max/min-width

```scss
@media (min-width: 600px) {
  /* styles for 600px and up here */
}
@media (max-width: 38em) {
  /* styles for 38em and up here */
}
```
