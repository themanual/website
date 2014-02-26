# 1. The Manual

The Manual, Everywhere is a project that turns The Manual from just a print publication with an online store to a multi-format, multi-device publication, whose online presence is a fundamental and continuous part of.

The Manual will continue to be published three times a year, in issues with six articles and lessons by six writers each. Each issue has a specific color (used in the cover, some parts of the text, and as the main color of the issues’s illustrations).

Three issues constitute a Volume — Vol. I with issues 1, 2 and 3, Vol. II with issues 4, 5 and 6 and so forth. Each print edition of a Volume will be designed by a different designer, and may have a different cover, materials, typefaces, size, and page design.

The website will be consistent only with itself, and not be redesigned with each Volume. However, the color of each issue (and its articles) will play a part in the website design.

The website is meant to be an online product in permanent evolution, much like any digital product. The work on it won't be “finished” on the first release, as we want to tweak existing features or add new ones as time progresses. As such, we want the relationship between The Manual and the development team to be ongoing and long-lasting.

## 1.1. Publication Schedule
As we predict it, the publication schedule is as such:
- **Jan:** Periodical
- **Feb:** --
- **Mar:** Issue
- **Apr:** --
- **Mai:** Periodical
- **Jun:** --
- **Jul:** Issue
- **Aug:** --
- **Sep:** Periodical
- **Oct:** --
- **Nov:** Issue
- **Dec:** --

Notes:
- In Periodical months, we'll publish one or two pieces.
- The Blog doesn't follow a strict publication schedule.

# 2. Scope

## 2.1. Sections

The website has 4 major sections: Issues, Periodical, Blog, and Store. The About section and Home page are worth mentioning too.

### Issues
Issues is the online edition of The Manual’s issues. They will be available publicly, without login or paywall restrictions.

### Periodical
Periodical is a web-exclusive branch of The Manual, that publishes one or two pieces three times a year (two months after an issue). The success of Periodical may shorten this interval.

### Blog
Pretty straightforward, mostly news about The Manual, on non-strict publication schedule. We may want to post links to other stuff that may appeal to the niche audience of The Manual, so it's possible that we'll need *post types* (in Tumblr fashion, but fewer types than Tumblr permits).

### Store
Store is the one-stop place for everything that can be bought from The Manual. That includes digital and physical Issues or Volumes, prints, merchandise, and Subscriptions. The Store needs to be able to talk to Shipwire via its API.

### About
A group of static pages. Contacts, Sponsorship, Terms, etc.

### Home
The home page will adapt to whatever we want to feature. We’ll need to fetch data from Issues, Periodical, Store, and Blog. Plus, we’ll want to have a custom “Highlight“ here. Ideally, there will be a few variations of the layout/design of this page that we can use depending on the cirumstances.

## 2.2. Site Map

* **Issues:** `/issues`
  * Single Issue: `/issues/[#]`
  * Article: `/issues/[#]/articles/[author]/[title]`
  * Lesson: `/issues/[#]/lessons/[author]`
* **Periodical:** `/periodical`
  * Post: `/periodical/[permalink]-[title]`
  * Archive: `/periodical/archive`
* **Blog**: `/blog`
  * Post: `/blog/[yyyy/mm/dd]/[id]-[title]`
  * Category: `/blog/[category_name]`
  * Archive: `/blog/archive`
* **Store:** `/store`
  * Product: `/store/[product_name]`
  * Subscription: `/store/subscription`
  * Cart: `/store/cart`
  * Checkout: `/store/checkout`
* **About:** `/about`
  * Sub-Pages: `/about/[permalink]`
* **Admin:** `/admin`

# 3. Considerations

## 3.1. Advertisement
All non-Store content will be free, but the site will be ad-supported. First, we'll take sponsorship (weekly or monthly is yet to be decided) ourselves, with Deck/Fusion-looking ads and text. Possibly, if pageviews are enough, we may move to an ad network.

For that, we'll need to be able to schedule advertisement for any periods, and extend those periods. These advertisements are just a image, a link, and a text (that may contain links itself).

## 3.2. Customer Login
As everything is free, user login is not a requirement or even encouraged. We'll want people to be able to sign-in to be able to extend or cancel their sponsorship (we're considering letting people do this via email, too), as well as change their store details (name, postal address, that sort of thing).

Since these actions will likely be very infrequent (much like the publication of new issues), we'd like to try not to force a traditional username/password account creation, and attempt at a password-less login with verification using email.

Here's how that would work:

1. Customer tries to login, using their email
2. The Manual looks for previous purchases using that email address, and sends that user a email containing a link with a long hash. This link should expire after a small period of time.
3. Customer clicks that link, and is taken to the site, logged in, and a cookie is set so he/she doesn't have to log in again.

## 3.3. Newsstand App
A Newsstand app for The Manual is in the works. We'll have to extend the passwordless login to the Newsstand app (which could be done by the app only), but we'll have to check subscription status with our website via a private API call.

## 3.4. Payment Emails
A customer may have several email addresses, and may have or provide distinct email addresses for logging in and PayPal accounts. As such, users need to be able to add those emails to their customer account, mimicking Bandcamp's behaviour which works very well.

When adding a new payment email to their account, an email would be sent to that account, containing a link with a long hash. Upon clicking that link, the logged in user would have that email address added to its account. Any items purchased with said email address would be added to the customer's purchase history, (which may grant him access to download corresponding ebook editions).

Any single email can only be associated with one user.

Adittionaly, a customer should be able to:
- Login with any of his/her emails, not just the primary one.
- Set any of his/her payment emails as the primary one.

## 3.5. Store
The goal for the store is the same as for the rest of the project: reader-friendliness is everything.

### Shipwire
The store needs to use Shipwire's API. Shipwire is a warehouse and distribution service used by The Manual to automatically calculate shipping costs and automate shipping, so it's never necessary to manually process any order or shipment.

### Promotions
Whenever possible, discounts or promotions should be directly applied when a user/order/product is elligible for them. This means no promo codes except when absolutely essential. Instead, logged in users will see their tailored discounts right in the store. If a product is discounted for everyone, its price should reflect that discount. Field Notes puts this very nicely:

> Today only, buy anything from any of our brands and get a Field Notes 18-Month Workstation Calendar free. No coupon codes. No minimums. No bull. Heck, you don't even need to be aware of the deal. If you buy something today, you're in.

However, we'll want to use promo code in specific circumstances, usually for new customers that in a specific group of people (for example, a private promo code for attendees of a conference, or listeners of a sponsored podcast episode).

We *may* also want to be able to apply any promotion to a specific user. (Example, a package is damaged because the postman left it in the rain, we may want to give that user a discout on the same product and/or free shipping.) This should also be able for new customers about whom we don't have information at all, with one-time promo codes or gift codes that expire after usage.

We're aware that this is very complicated. Ideally, we'd want to look for an existing solution that we could build upon, to reduce development time, cost and lower the barrier of entry to future updates by whoever's assigned/contracted to do it.

## 3.6. Email
The Manual will use email a lot. Emailing can be divided into two:

- **Email Campaigns**, that target existing or past customers of The Manual, based on purchase history, activity, and other criteria. People should be able to unsubscribe from these emails.
- **Transactional Emails**, which are sent on user-triggered events such as purchases or login. People can't unsubscribe from these.

We want to make use of existing campaign and transactional email, instead of having a custom-tailored solution:

- For **Email Campaigns**, we currently use Campaign Monitor for all Fiction projects, but are open to switch to Mailchimp if their feature set suits The Manual better.
- For **Transactional Emails**, we've used Mandrill in the past, but are open to use SendGrid or Amazon SES if they prove better.

Both types of emails should be formatted as HTML with responsive templates, and may use images, and should have the same design, hence identical templates.

Transaction emails are fairly simple, but we want to take advantage of everything we know about our customers to target specific segments to offer them promotions. The goal is two-fold:

1. **Never bother people unnecessarily.** A customer should only receive an email campaign if it contains information or promotions useful to them. This leads to less unsubscribes and generally a good demonstration of respect by The Manual. A few examples:
	- Inform people that they can download digital editions of previously purchased editions, but only for people who haven't done that yet.
	- Email everyone who has purchased two issues in a volume, offering them a discount on their missing issue.
2. **Monitor and increase revenue.** By segmenting customers, we will always send promotions to those that can take advantage on them. So we want to be able to monitor if people took action after getting emails with offers or promotions, when and how much they spent, that sort of stuff.

Developing a custom tool to enable us to do this would be very costly and time-consuming, and that's why we want to use existing products that let us do this easily.

However, all information on purchase history and activity will lie on our database. This is where it gets more complicated. So we'll effectively need to sync our customer information to that product at any time this information changes.

We'll need to decide which tool that is based on three factors:

1. **Feature set**. Segmentation, profiles, analytics are important.
2. **API.** Endpoints for customer information and history syncing are important. Existing wrappers and extensive documentation, which help reduce development time, are good as well.
3. **Cost.** We'd like to minimize recurring and development cost.

### Contenders

**Campaign Monitor & Mailchimp**
Classic email newsletter apps such as [Campaign Monitor](http://www.campaignmonitor.com) and [Mailchimp](http://mailchimp.com) have very powerful email-sending capababilities, both in terms of segmentation and customization, and do OK in terms or profiles, especially Mailchimp. Plus, they have great email design and spam testing features, as well as analytics.

However, while these tools have powerful segmentation capabilities, they seriously lack in custom data tracking and analytics. They allow it, but it's clearly not their priority, and that reflects in their APIs, better suited to email sending than managing custom data. They do it, but again, it's second nature.

**Intercom**
[Intercom](https://www.intercom.io) is a customer tracking and communication tool, very focused on collecting data from signed-in users/customers. It has very powerful tracking features, allowing flexible custom data, as well as something they call “increments” — you can tell Intercom to change some custom user parameter by a certain amount "this user +1 download" or "this customer spent +$33". The simplest way to interact with Intercom is via their JavaScript library, but they have Ruby, Ruby on Rails, and iOS libraries available — the latter useful for The Manual's Newsstand app.

On their end, they have very powerful segmentation features for communicating with users, either in-app or via email. Things such as — email users who haven't signed in the past month, and have no downloads — which newsletter services aren't so good at. Intercom also handles incoming email, so it functions as an help desk too, and one with a lot of detailed customer information.

However, email-focused tools like design and spam testing, or custom layout builders, are not present, though they allow custom HTML templates for email communication, and previewing them, but have to be design tested somewhere else.

Furthermore, Intercom can be used through Segment.io, which acts as a proxy for multiple analytics and marketing tools, letting us use a single Javascript call to track user information for both Intercom and a web analytics tool — such as Google Analytics, Mixpanel, Chartbeat, or many others. As a curiosity, Segment.io lets customers swap and add new analytics services without having to change the code on their pages.

### Documentation

All of these contenders have good, well documented APIs. We'd like your input in their depth, quality and ease of integration.

For reference, here are the URLs for the main contenders:
- **Campaign Monitor:** http://www.campaignmonitor.com/api/
- **Mailchimp:** http://apidocs.mailchimp.com
- **Intercom:** http://docs.intercom.io/#IntercomJS +
http://docs.intercom.io/api


## 3.7. Administration
The only users will email/password will be the staffers. Writers don't post anything themselves, staffers do, even for the blog. It's still up for debate, but we'll probably want to have a two-tier Staffer system, with Staffers and Administrators.

## 3.8. Text Syntax
We'll want to use a text syntax that supports our content:
- Issues are mostly running text, with subheads, and possibly quotes and footnotes.
- Periodical, as a new and web-only section, is still very undefined. But we'll want to take advantage of the medium being exclusively the web, and let authors use video, animated imagery, and (possibly) a custom layout or anything we haven't thought of yet at that moment.
- Blog will be mostly text, subheads, and images or video embeds.

As we see it now, there's no reason why Markdown — and its ability to make use of HTML code in the document — couldn't fit all of these content formats. Not simply Markdown, but MultiMarkdown, due to its extra syntax features that are useful to us, such as footnotes, image captions, cross references, and others.

## 3.9. Development

### Modularity & Documentation
Historically, Fiction's project have had a lot of custom-made tools and products. While it reduces recurring costs (at the expense of a bigger one-time development cost), and has less points of failure (because it doesn't rely on other services), it poses a big problem: the more custom code, the harder it is for the code to change hands between developers in different teams.

This has been a big problem so far, which ended up in having different development teams do the **same thing** from scratch in different years, because that's a lot of times easier than digging into other people's undocumented code.

While we absolutely want to have a long-lasting relationship with The Manual's development team, people are likely to change jobs, companies merge or get acquired — it's the natural way of things.

In order to mitigate the effects of this happening, we want development to be guided by three major concerns:

1. Use existing services or software that:
	* are stable and in active development
	* are likely to last a long time
	* have reliable uptimes (for 3rd-party services)
2. Heavily document any custom code so it's easy to learn by any future team members or other developers.
3. Extensively test all code, so any future work doesn't break existing use cases, features or permissions.


### Caching
The site should cache the written content that doesn't frequently change: Issues, Periodical, Blog, About. Because of the very occasional publication schedule, and lack of dynamic content (such as comments), we're in a position to not have to hit the database very frequently.

### Hosting
At Fiction, we usually rely on (mt) for simple hosted websites, and Heroku for apps with heavier load. This is still up for debate. We'll want to maximize uptime and request speed, and minimize recurring costs.

### Legacy Customer and Order Information
The Manual has had two different online store so far, hence two different databases and data models:

- A custom-made web app with loads of information.
- A Shopify shop with way less information.

We will need to perform a one-time operation to import all of this information to the new site, detect returning customers, and merge everything into an unified database without duplicate customers. We also have over 6000 email addresses from our Campaign Monitor account on The Manual's newsletter, which have to come together with order information. Access will be provided to both stores.

# 4. Data Model

The data model for the project isn't complete and should be in constant refinement as development progresses. The development team is expected to contribute to this data model.

### Issue
- has a *title/number* (arabic numeral, such as Issue 1)
- has a *publication date* (Summer 2011, Fall 2013, etc.)
- has a *publishing state* (public or staffer-only)
- has zero/one **Introduction**
- has six **Articles**
- has six **Lessons**
- belongs to one **Volume**
- has zero/one associated **Product** (physical/digital edition)

### Volume
- has a *title/number* (roman numeral, such as Volume I)
- has three **Issues**
- has zero/one associated **Product** (physical/digital edition)

### Introduction (type of Writing)
- has a *body*
- belongs to an **Issue**
- belongs to a **Writer**

### Article (type of Writing)
- has a *title*
- has a *body*
- has an *illustration*
- has an *illustrator*
- belongs to an **Issue**
- belongs to a **Writer**
- has zero/one associated **Product** (print of the illustration)

### Lesson (type of Writing)
- has a *body*
- belongs to an **Issue**
- belongs to a **Writer**

### Piece (type of Writing)
*(A Piece is an article from the Periodical)*
- has a *title*
- has a *body*
- has an *illustration*
- has an *illustrator*
- belongs to a **Writer**

### Blog Post (type of Writing)
- has a *title*
- has a *body*
- has a *publication date*
- has zero/many **Categories**
- belongs to a **Writer**

### Writer
- has a *name*
- has a *biography*
- has zero/more **Avatar**
- has zero/more **Writings**

### Avatar
- has a *picture*
- belongs to a **Writer**
- may belong to an **Issue** (this allows us to know which picture to use in case an writer writes in both an Issue and Periodical)

### Staffer
- has a *name*
- has an *email*
- has a *password*
- has a *role* (staffer, admin)

### Product
This should closely follow Shopify's product data model

### Order
This should closely follow Shopify's order data model

### Customer
- has a *name*
- has a *email*
- has an *address*
- has zero/more *payment emails*
- has many **Orders**

### Advertisement
- has a *link*
- has a *picture*
- has a *body*
- has a *start date*
- has a *end date*

# 5. Feature List

**Everyone** can:
- Read Issues, Periodical, and Blog
- Purchase at the Store, becoming Customers
- Login (password-less) to their Customer account

**Customers** can also:
- See Store promotions
- Cancel or renew their subscription
- Change their customer details
- Add more payment emails

**Staffers** can also:
- Create, Update and Destroy:
	- Issues, Articles and Lessons
	- Periodical pieces
	- Blog posts
	- Store Products and Promotions
	- Customer details
- See unpublished Issues
- Renew/cancel/gift customer subscriptions
- Schedule and manage advertisements

**Administrators** can also:
- Create, update and destroy **Staffers**
- Promote staffers to **Administrators**


## post-checkout flow

After a user completes the checkout form successfully the following happens:
- Their user account is created (A User instance is created)
- Their address is saved and made the default shipping address (A Address instance is created associated with the User, and the users shipping_address_id is set to it)
- Their stripe token is saved (A Card instance is created (including expiry and last 4 digits) associated with the user, the user's id is added as metadata)
- The user is signed in (should we maybe confrim the purchase and the login via an email? **)
- A subscroption is created (a Subscription instance, with their price paid noted)

*not yet implemented, but will happen*
- An order created for the selected start issue (immediate order in the case of the current issue, or a back-order in the case of the next issue)
- Email confirmation send (see above **)
- Handle validation of user/address data better ()
