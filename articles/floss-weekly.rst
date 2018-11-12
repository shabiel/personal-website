FLOSS Weekly Write Up for VistA/RPMS Show
=========================================

Introduction
------------
I am Sam Habiel, Director of Product Management at OSEHRA
(https://www.osehra.org/), and have been involved in VistA/RPMS for about 10
years. I have been a long time listener to this show; and I can easily answer
the two final questions! I am a pharmacist as well. I helped bring on Harlan
Stenn to talk about NTP on show # 350
(https://twit.tv/shows/floss-weekly/episodes/350). Harlan and I have a common
connection you see--we are both involved in the M/MUMPS world. M is a
programming language that is widely used in Medicine; and has been less widely
used in Banking. Harlan used to maintain an M implementation; and was on the
Mumps Development Committee (MDC). My boss at the time knew Harlan and I was
surprised that he was responsible for NTP; and so I thought I would bring him
on to the show.

Nancy Anthracite is the president of WorldVistA, and is a currently practicing
physician. Nancy has been more responsible than anybody else for the success of
open source world in VistA. I will let her speak for herself.

What is VistA/RPMS and who needs it
-----------------------------------
VistA/RPMS is a big suite of mostly Electronic Medical Record (EMR)-related
software. It was developed by the Department of Veterans Affairs and Indian
Health Service in the United States. It's viewed by many as a national treasure.

VistA/RPMS is government developed software, and thus is in the public domain.

VistA has had a big international success, esp.  in countries where Medicine is
practiced in English: 16 hospitals in India that we know of; and above 50
hospitals in Jordan, where it was implemented across all government sectors.

In the United States, it is used by around 20 independent hospitals, all 23
hospitals of the New York Mental Health System and the Tennessee Department of
Health and a State Mental Health hospital in North Carolina. Various health
systems around the US use parts of the VistA infrastructure to provide medical
applications--for example, John Hopkins Medical Center in Baltimore. There are
many smaller installations around the world that we are not aware of. VistA has
been previously implemented across a big part of the public sector of Mexico's
hospitals, but the status of that implementation right now is not currently
known. I would love to know.

RPMS has unfortunately not found much open source success outside of Indian
Health Service. RPMS has a very strong population health component; and it has
found favor in places like Hawa'ii, American Samoa, and Guam which sought to
track the health of their population closely. RPMS is mainly an Outpatient
System.

VistA is finding big success as an educational system for training nurses and
physicians. It's currently known to be used in Johns Hopkins and University of
Michigan, and it is certainly used in other Universities which we do not know of.

Many of the places in which VistA and RPMS are used are not using open source
implementations.

Story of VistA
--------------
We can spend the entire podcast episode talking about the history of VistA. The
beginning history is summarized really well in an article on the hardhats
website (http://www.hardhats.org/history/hardhats.html). Until recently, we didn't
have a good recent history that describes what happened after the initial push;
Arthur Allen of Politico published an article last year to update the history:
https://www.politico.com/agenda/story/2017/03/vista-computer-history-va-conspiracy-000367.

A quick summary: it was never an official sanctioned effort to create an electronic
medical record system inside of the VA. It started as an underground effort; and
earned the nickname "Underground railway" by Nancy Tomich in US Medicine. The
VistA/RPMS programmers call themselves hardhats; thus the name of the website
and the name of the VistA/RPMS mailing list.

Story of RPMS
-------------
RPMS was more officially sanctioned than VistA was. I am proud to say that I
was the one to have written the definitive history of RPMS, which you can find
here http://smh101.com/articles/Hx_RPMS_final.html. RPMS started with the same
infrastructure as VistA, but implemented a lot of new applications on top of them.
There is a good reason for that: Before the 1990's the VA was an inpatient only
system; IHS had both Inpatient and Outpatient; but it was mostly outpatient. By
necessity, IHS couldn't use the same clinical software as the VA. In the next 20
years, a lot of IHS code went back into the VA; and a lot of VA code was used
by IHS.

Story of CHCS
-------------
We should give them a passing mention. CHCS is the Department of Defence's
Inpatient System and also the system used in the Battlefield. It's built on
VistA but is proprietary. There is a long story of how superior VistA was to
the competition when the DOD bid for the system; but I won't relate that here.

What does VistA/RPMS consist of?
--------------------------------
VistA consists of around 150 sub-modules, some independent, but most tightly
integrated with each other. As recently as 2016, it has been rated as the most
usable Electronic Medical Record by a Medscape survey (https://www.medscape.com/features/slideshow/public/ehr2016). Most people outside of the VA are interested in about 10-20 modules, including

* Order Entry
* The big 3 ancillaries: Lab, Pharmacy, and Radiology.
* Barcode Administration
* Vitals Recording

VistA includes many non-EMR functions. E.g. Financial Management, Inventory,
Police & Security, Incident Reporting, Circulars Tracking for Libraries, and
Payroll processing.

RPMS, in addition to many of the core functionality in VistA, also includes a
lot of modules focused on Women's Health, Children's Health, and Population
Tracking. The latter part is unique, as it is usually an after thought in any
EMR.

What is VistA/RPMS written in?
------------------------------
The story of VistA is intimately tied to the story of the M programming
language.  The M programming language was standardized by ISO; and provided a
solid foundation for storing medical data. Medical data is very sparse (i.e.
most data points have very little data); and existing technology in the late
70's had difficulty storing the data in that manner. The other big advantage M
had was that it was a vendor neutral language: You can develop your system and
use any vendor for the M implementation that you wanted and switch between them
anytime you needed. M turned out to be stable enough in the long term; which
helped big government customers who couldn't upgrade their code every year.
The choice of M for VistA was a very deliberate one and it turned out to be an
amazingly successful choice.

M is a database language; and did not have very mature Windows bindings. For a
reason lost in history, Delphi was chosen in the VA to write the Windows
Clients in the mid 90's.  In IHS, Visual Basic was chosen. I view the choice of
Delphi as a very fortunate accident. It was easy to write applications in; it
does not have an major security issues; and it has a vendor that continuously
supports it. People who wrote their code in Visual Basic 6 saw their language
deprecated; and the attempts to write a Java Windows clients in a government
environment where updates could not be made frequently proved to be a problem.
Delphi, unfortunately, is not open source, and until a few months ago, it was
expensive to get a license. Now Embarcadero offers free licenses for a community
edition.

After the initial Visual Basic clients that RPMS had, RPMS moved to Delphi and
.Net at the same time. .Net has been a mixed blessing for RPMS.

It's obvious now that all of these are Windows thick clients. Of note, many of
the Delphi applications work on Wine. Web clients for VistA/RPMS are not common
unfortunately.

Role of Citizen Developers in the success of VistA/RPMS
-------------------------------------------------------
The term "Citizen Developers" is not well known. It not common in the open
source world where usually developers and users of the software are both
the same people. The big problem in healthcare is that the developers almost
never get to use the software they wrote. Citizen developers are end users who
have no training in developing software but who learn it in order to better
perform their job duties. We have all seen them. They are the people who write
massive excel spreadsheets with macros.

We found out over the last 40 years that it was very difficult for professional
developers to write software if they do not have an intimate idea of the job
functions. It was worse when there is a list of requirements on a sheet of paper
and a contract to perform the programming. Citizen developers were what made
VistA/RPMS successful. They could write applications that show exactly what the
final application should do. Many of these applications were incorporated
wholesale into VistA/RPMS.

Aside from this, people eventually figured out that it was easier to teach a
medical person to code rather than a computer science major to understand
medicine; and a lot of Citizen Developers made the transition. RPMS, for
example, was almost entirely written by people with medical backgrounds; and,
for a change of pace, a lot of code was written by women. Lori Butcher has been
very prolific, for example. She was not technically in Medicine, as she was a
public health researcher prior to her career as a programmer--again, notice the
population health connection for RPMS.

Story of VistA/RPMS Open Source Community
-----------------------------------------
This is not an easy story to relate. There are so many different threads to the
story. The success of the open source community involved so many actors. Thank
you to Joseph Dal Molin, Maury Pepper, David Whitten for helping me put together
this history.

The first thread is the Hardhats community thread. Greg Kreis, George Timson
and Greg Woodhouse started the Hardhats website (hardhats.org) and the mailing
list (which is currently a google group called hardhats) in the mid 1990s. The
initial reasons for doing so involved an internal threat to the VA mail network
for exchanging information about VistA: the system's name was called FORUM. The
decision was a wise one; and the dissolution of FORUM came to pass in the early
2000s. It has a nice big political story behind it, but we won't go into that
here.

The hardhats website is an icon in the VistA Community. Its design is dated,
but one of the most memorable aspects about are the windows which light up when
you hover over them. The Fileman "house" is particularly subversive: When you
hover over it, one of the Windows has an X on it. This is a reference to the
X files, a TV show from the 90's. From the X Files wikia:

  "X" was the codename for one of Fox Mulder's informants and a member of the
  Men in Black. Although X's real name was never revealed, he became known as
  "X" or "Mr. X" because Mulder would seek his assistance by marking an "X" in
  masking tape on his apartment window.

The second thread is the Object Oriented Extension Committee in the Mumps
Development Committee (MDC). Many members of that committee were VA employees
involved in the maintenance of VistA. The VA was making noise at that time about
getting rid of VistA. The MDC members were galvanized by Rick Marshall, who
said, "How can we save VistA?" At the same time this was happening, but
independent from it, Sanchez Corporation was about to open source GT.M. VistA
currently at the time did not run on GT.M (a small amount of code was needed to
do it), but having a fully open source stack for running VistA was another
motivator to get it done. This second group was a more social group than the
original one: many in person meetings and hackathons happened, and the code to
run VistA on GT.M was written during these hackathons. That group eventually
became WorldVistA.

The third thread is the launch of the OpenHealth discussion forum, which
brought together early pioneers to share experiences, code and co-creating a
value proposition for open source in health. Vista aficionados begin to
congregate on forum. The OpenHealth list discussions catalyze the formation of
the Open Source Health Care Alliance (OSHCA). Following OSHCA's inaugural
meeting in Rome in 2000, Colin Smith of NHS England offers to host second
annual OSHCA community meeting in London, Sept. 2001. Rick Marshall and Chris
Richardson of Hardhats attend along with K.S. Bhaskar announcing porting of
VistA to then Sanchez’s GT.M. The meeting catalyzes subsequent formation of
WorldVistA by Rick, Chris, Maury, Bhaskar, Joseph, David, Larry and Brian (I
may have left one founder out). In 2002, WorldVistA incorporated as 501 (c) (3)
and decision is made to leverage the Hardhats community rather than create a
separate one focused on open source. VistA community meetings are launched and
held twice a year.

The fourth thread is the start of VistA Office Project (VOE), sponsored by the US
Department of Health and Human Services. President Bush (yes, no kidding!)
issues executive order which sets in motion the creation of the CMS led VistA
Office EHR project in collaboration with VA and IHS. By the way, DoD never joined the
party. "Within 90 days, the Secretary of Veterans Affairs and the Secretary of
Defense shall jointly report on the approaches the Departments could take to
work more actively with the private sector to make their health information
systems available as an affordable option for providers in rural and medically
underserved communities." President Bush's Executive Order – April 27, 2004. In
2005, WorldVistA is awarded the community and capacity building contract to
establish a training program and network of vendors that can implement and
support VOE. WorldVistA is subsequently asked to takeover development of the
VOE software as well and creates both a full open source version as well as a
Cache based version.

The fifth thread is Nancy Anthracite, my co-presenter. She ties many of these
threads together. She became very enthusiastic about VistA after seeing a
demonstration of the Barcode Medication Administration Program. She spent a lot
of time putting together instructions from various experts on how to install
VistA. Prior to her efforts, there were no public or non-public instructions on
how to install VistA for a new instance. She was eventually persuaded to join
WorldVistA, and she is now the president of WorldVistA.

The story goes on from there... Of note, in 2007, WorldVistA wins Wired
Magazine Rave Award for innovation in medicine for its VistA open source
community building and software development.  In August Jordan's Royal Court
initiates the planning phase for its VistA adoption initiative. Jordan starts
looking at implementing the software in 2009.

Challenges of Open Source with VistA
-----------------------------------
VistA is a unique piece of software. It's difficult to implement for in real
life, as it requires an extraordinary amount of coordination; and you can only
become an expert at it after using it for a few years. Here are some of the
challenges with doing open source with VistA:

* Most people take and implement the software without giving back. Most of the
  software is public domain, so giving back is not required by a specific
  license. However, we noticed that even users in India and Jordan, when they
  modify GPL licensed code, they do not give back their code.
* VistA has no good legacy of using version control to control the source code.
  Most people developing VistA today do not use source control; and as such,
  reusing existing open source infrastructure is not easy.
* The presence of a "mother ship" has discouraged peer to peer sharing.
* Outside of WorldVistA and OSEHRA volunteers and members, open source culture
  does not pervade the community.
* WorldVistA does not have a business model, and is mostly staffed by volunteers.
  Even when code does come that could be incorporated into WorldVistA, it is
  often a proposition of whether we should take the code and maintain it, or
  keep it as an external component for others to use but not shoulder the effort
  to maintain it.
* Almost all end users are not coders; so even when they want to modify the
  software, it's difficult to know where to get started and how.

No appreciable community has formed around RPMS unfortunately.

Open Source and VistA/RPMS Today
--------------------------------
By 2011, the Jordan implementation has implemented around 3 hospitals; and there
were around 5-10 hospitals in India that implemented VistA. VistA's luck in the
US outside of the VA was not so good, in competition with commercial systems; it
found favor in Mental Health facilities, mainly due to economic reasons.

By 2011, the open source community around VistA was significant--so much so that
the VA was persuaded to try to take in some of the innovations of the open
source community; and the VA wanted to try to work with the open source community
to solve some of the internal problems they have been having. The VA let out
a Request for Proposals and a contract to form OSEHRA, which stands for Open
Source Electronic Health Record Agent. The last A became Alliance later as
OSEHRA sought to establish its place in the ecosystem around VistA. I work for
them today. OSEHRA did several innovative things that were either not completely
done before, or were consolidations of previous work. These include:

 * Full version control for VistA/RPMS.
 * Easy to run version of VistA and RPMS for experimentation and development.
 * Consolidation of all educational content related to VistA in a single area.
 * Certification for software going into VistA/RPMS.
 * Preaching the gospel of Unit Tests as the way to create assurance in maintaining
   software.

One big problem the open source community always had was the inability to
officially collaborate with the VA on VistA software. OSEHRA has helped solve
this problem for now.

OSEHRA runs a large amount of working groups on various aspects of the software;
and we can talk about on how to participate if you want to.

OSEHRA is a relative newcomer to the VistA Open Source Community, and there was
some friction with WorldVistA; especially as regards licensing issues.
WorldVistA prefers copyleft licenses; whereas OSEHRA prefers non-copyleft licenses.
The reasons for the license differences are easy to understand when you understand
the financial models behind OSEHRA and WorldVistA; and in the open source
community at large. I don't want to dwell here on this issue. Suffice it to say
that OSEHRA's open source participation is by and large from the pre-existing
open source community that existed prior to OSEHRA's formation--which I guess is
a vindication of the original goals of starting OSEHRA in the first place.

We talked a lot about VistA in this section; it's time to mention RPMS as bit.
As I said before, RPMS never found the success that VistA has. However, its
strong focus on Population Statistics; and Womens' and Childrens' health earned
it favor in areas with disadvantaged populations. RPMS was implemented in 
Hawa'ii, Guam and American Samoa.

Software for Download
---------------------
VistA is a very large collection of software. The best thing to do to try it
out is to download our so-called "VEHU" instance, which has a lot of test data.
It is available as a docker image running on GT.M. Go to osehra.org, click on
Projects, and then click on VistA/RPMS. We have docker images for RPMS as well,
but we do not have any instances that have data in them like we do for VEHU.

OSEHRA does not make deployable software. We have member companies like DSS
and Medsphere that deploy VistA with some open source components and some 
proprietary components. WorldVistA makes a completely open source VistA, and
it is available to download from the WorldVistA-EHR project on sourceforge.org
(https://sourceforge.net/projects/worldvista-ehr/). I do want to make it clear
that if you don't pay for support from somebody, all you will get is some
volunteer support on a mailing list, which is typical of any open source
project.

What can we offer the FLOSS Weekly Community?
---------------------------------------------
People come to us for two big reasons: They want to implement an Electronic
Medical Record  (EMR) in their hospital/clinic; or to create an educational
curriculum for doctors and nurses for using electronic medical records.
Implementing an EMR is actually pretty difficult: it takes a lot of 
non-technical skill to pull off. That's a big reason why commercial EMRs did
better than open source ones. It's such a difficult managerial topic--I don't
know how much I want to talk about this here. Creating an educational curriculum
is comparatively easier. The other thing we should mention is that many people
use the VistA infrastructure to create their own applications, sometimes having
nothing to do with medicine. I think this still has value today, especially if
you want something with Java's long shelf life without it being Java. M is an
easy language to learn and can give you a lot of power very quickly.

There are about three conferences a year that are VistA related. WorldVistA puts
on two "VistA Community Meetings" and OSEHRA puts on an "OSEHRA Summit", which
is less focused on VistA but more focused on open source in Healthcare and in
Government. The VistA Community Meeting is the more technical meeting; and so
if you are a developer, that is what you should come to.

How can I learn more about VistA/RPMS?
--------------------------------------
The best places to learn about VistA and RPMS is at hardhats.org; and then at
the educational section of the osehra.org website. There are some very nice
videos there--I especially recommend Greg Kreis's VistA Foundations video on
our website. To try VistA/RPMS, I recommend the docker images as above. Finally,
we have the hardhats mailing list, which is where you should ask your questions.

How can the FLOSS Community Help Us?
------------------------------------
If you are interested in participating, asking you to jump into coding is too
much to ask as this code requires significant expertise just to get started. But
there are some items we would love to have help on:

* OSEHRA has many project groups; one of the more important ones in my opinion
  is a project to create synthetic patients. Synthetic patients are important
  because we cannot use anonymous patient data in most scenarios as it is very
  easily re-identified. This is a non-VistA project; it's in Java (previously
  in Ruby, but Ruby was too slow); and we would like participation for people
  to work on more modules or to look at the data and see how realistic it is.
  We also have an on-going project for importing this data into VistA.
* OSEHRA is working on a project to make VistA suitable for countries that do
  not practice medicine in English. I am the lead on that and I want testers
  who can run the software in their native locale and see if I missed something.
  I need German speakers and Arabic Speakers. If you can translate parts of
  VistA in your own language, I would appreciate it as well.
* Wine (the Linux software) needs some modifications to run CPRS. The latest
  thing it needs is an implementation of Winsock2.
* WorldVistA is always looking for venues that are willing to host us for free.
  Usually these are universities of some kind.
* VistA has a specific TCP wire protocol. It would be nice if somebody can write
  a Wireshark dissector for that.
* Finally, it's important to note that VistA is part of a bigger ecosystem. There
  are other projects around it. If you are interested in HL7 for example (HL7 
  is a medical data interchange language), you should get involved in Mirth. If
  you are involved in quality reporting in the US, you should get involved in
  Pop Health.
