#!/usr/bin/env perl
package Resume::Template;
use strict;
use warnings;
use Template::Declare::Tags; # defaults to ’HTML’
use base 'Template::Declare';
use List::Util qw/first/;

# made to be an array for the ease of maintaining order
my @sections = (
        [
            education => sub {
                my %data = (
                    'University'           => "Pennsylvania State University",
                    'GPA'                  => '3.47/4.00',
                    'Expected to graduate' => "Summer 2009",
                    'Status'               => q{I have <strong>three classes left</strong>, and I plan to finish them all as on-line classes from mid-May to the end of June.},
                );

                table {
                    for (keys %data) {
                        row {
                            cell { b { $_ }  }
                            cell { outs_raw $data{$_} }
                        }
                    }
                }
            },
        ],
        [
        skills => sub {
            my @skills = (
            [
                q{Programming} => sub {
                    ul {
                        li { "Perl (Jifty, DBI, Test-driven Development)" }
                        li { "Ruby on Rails" }
                        li { "Java (Servlets, JSP, Database, Networking)" }
                        li { "PHP (CakePHP, Drupal)" }
                        li { "JavaScript (Basic DOM, jQuery)" }
                    }
                }
            ],
            [
                q{Tools} => sub {
                    ul {
                        li { "Editing: Vim, Dreamweaver, Eclipse (original, Aptana), Netbeans, GIMP, Photoshop" }
                        li { "Utilities: Apache, FastCGI, Bourne Shell" }
                        li { "Networking: IPTables, BIND 9, PF, Kickstart" }
                        li { "SCM: Subversion, darcs, git" }
                        li { "Database: PostgreSQL, MySQL, SQLite, SQL Server (2000 and 2005)" }
                        li { "Tracking: AgileTrack, RT" }
                        li { "Misc: XML, YAML" }
                    }
                }
            ],
            [
                q{Operating Systems} => sub {
                    ul {
                        li {
                            "Linux: ".
                            join  q{, } =>
                                'Gentoo 2007.0',
                                'Debian (Etch and Lenny)',
                                'Ubuntu',
                                'CentOS'
                        }
                        li {
                            "BSD: ".
                            "FreeBSD 6.x and 7.0, OpenBSD 4.x, OS X"
                        }
                        li {
                            "Windows: ".
                            join q{, } =>
                                'Windows 2000 (MCP)',
                                'Windows XP (SP 2 and 3)',
                                'Windows Vista'
                        }
                    }
                }
            ],
            );

            for (@skills) {
                my ($topic, $code) = @$_;
                p {
                    b { $topic } br {};
                    $code->();
                }
            }
        }
        ],
        [
            experience => sub {
                my  @experience = (
                    [
                        'Penn State York',
                        'Web Developer Intern',
                        '(June 2007 - Present)' =>
                        [
                            "Make updates to the campus Web site",
                            "Work on individual projects for the campus",
                            "Research Web technologies, ".
                            "such as web programming languages, CSS, ".
                            "and MVC frameworks for the Web",
                        ]
                    ],
                    [
                        'Freelance',
                        'Web Developer',
                        '(June 2007 - Present)' =>
                        [
                            "Write PHP/MySQL back-end code for Oz2designs",
                            "Make given static pages self-updateable",
                            "Release satisfactory sites for various local companies"
                        ]
                    ],
                    [
                        'Penn State York',
                        'Help Desk',
                        '(January 2006 - May 2007)' =>
                        [
                            "Solved IT-related problems among the campus"
                        ]
                    ],
                    [
                        'MCTG',
                        'Software Engineer',
                        '(September 2006 - January 2007)' =>
                        [
                            "Developed a large-scale HVAC Web site",
                            "Worked in a team of 9"
                        ]
                    ],
                );

                ul {
                    for (@experience) {
                        li {
                            my ($employer, $title, $era, $tasks) = @$_;
                            em { $employer }            br {}
                            b { $title } small { $era } br {}
                            ul {
                                attr { class is "job" }
                                li { $_ } for @$tasks;
                            }
                        }
                    }
                }
            }
        ],
        [
            projects => sub {
                my @projects = (
                {
                    name  => 'This resume',
                    url   => "http://github.com/jasonmay/resume/tree/master",
                    tasks => [
                        'Made with a Perl templating module: Template::Declare',
                        'Currently in development'
                    ]
                },
                {
                    name => 'Peacekeeper',
                    tasks => [
                        'Linux deployment project using CentOS and Kickstart',
                        'Designed for deploying computers on an isolated intranet',
                        'Deployed computers get donated to communities that need them',
                    ]
                },
                {
                    name => 'Dataninja',
                    url  => "http://github.com/jasonmay/dataninja/tree/master",
                    tasks => [
                        'Interface for a logging bot on Internet Relay Chat',
                        'Being developed for fun',
                    ]
                },
                {
                    name => 'Penn State Schedule Machine',
                    url  => "http://github.com/jasonmay/pssm/tree/master",
                    tasks => [
                        "A 'better' version of the official Penn State " .
                        "(eLion) weekly schedule generator",
                        "Uses AJAX (jQuery) to scrape course information",
                    ]
                },
#                {
#                    name => 'Photos',
#                    url   => "http://github.com/jasonmay/photos/tree/master",
#                    tasks => [
#                        'Made in Jifty, a Web app builder in Perl',
#                        'Being developed for fun',
#                        'Still a work in progress'
#                    ]
#                },
                {
                    name => 'Ruby on Rails CMS for my Capstone Class',
                    tasks => [
                        'CMS that was made in Ruby on Rails',
                        'Utilized agile methodology',
                        'Assigned to be the scrum master of the development team',
                        'Worked in a team of eight developers',
                    ]
                },
                {
                    name => 'York County Archives',
                    tasks => [
                        'Archiving system powered by Java Servlets',
                        'Involved hundreds of thousands of rows in databases',
                        'Involved converting MS Access to SQL Server',
                    ]
                },
                {
                    name => 'PSU WebAccess System Kit',
                    tasks => [
                        'Small kit used for providing Penn State student authentication',
                        'Aimed to be a drop-in bundle for Apache',
                        'Primarily written in Bash',
                    ]
                },
                );

                small { em {
                    outs 'Feel free to browse my ';
                    a { attr { href is 'http://github.com/jasonmay' } "Github" };
                    outs " repository.";
                } }
                ul {
                    for my $project (@projects) {
                        li {
                            if (exists $project->{url}) {
                                outs $project->{name} . ' - ';
                                small {
                                    a {
                                        attr { href is $project->{url} }
                                        'repository'
                                    }
                                }
                            }
                            else {
                                span {
                                    attr { style is "color: #000" }
                                    $project->{name}
                                }
                            }
                            ul {
                                li { $_ } for @{$project->{tasks}};
                            }
                        }
                    }
                }
            }
        ],
        [
            contributions => sub {
                p {
                    b { 'Perl Contributions:' }
                    ul {
                        li {
                            outs 'CPAN';
                            ul {
                                li {
                                    a {
                                        attr {
                                            href => 'http://search.cpan.org/~jasonmay/App-Dataninja-0.03/lib/App/Dataninja.pm'
                                        } 'App::Dataninja'
                                    }
                                }
                                li { 'Dataninja is finally on the CPAN' }
                            }
                        }
                    }
                    ul {
                        li {
                            a { attr { href => 'http://search.cpan.org/search?query=dbix::class' } 'DBIx::Class' }
                            ul {
                                li { 'Fixed a bug involving classless result sources' }
                                li {
                                    a {
                                        attr {
                                            href => 'http://dev.catalyst.perl.org/svnweb/bast/revision/?rev=6023'
                                        } 'The fix'
                                    }
                                }
                            }
                        }
                    }
                    ul {
                        li {
                            a { attr { href => 'http://search.cpan.org/search?query=Jifty::DBI' } 'Jifty::DBI' }
                            ul {
                                li { 'Implemented clear_order_by' }
                                li { 'Fixed various typos and updated documentation' }
                            }
                        }
                    }
                    ul {
                        li {
                            a { attr { href => 'http://search.cpan.org/search?query=Moose' } 'Moose' }
                            ul {
                                li {
                                    'MooseX::AttributeHelpers: ' .
                                    'Implemented curries for method providers'
                                }
                                li {
                                    'MooseX::AttributeHelpers: ' .
                                    'Added the Bool method provider'
                                }
                                li {
                                    'MooseX::NonMoose: ' .
                                    'Provided tests for extending classes ' .
                                    'that already use MooseX::NonMoose'
                                }
                            }
                        }
                    }
                }
            },
            ],
            [
            interests => sub {
                my @interests = (
                    [
                    q{Conferences and Workshops} => sub {
                        ul {
                            li { "YAPC::NA 2008" }
                            li { "Frozen Perl 2008" }
                            li { "Harrisburg Ruby Group meetups" }
                            li { "Harrisburg Linux User Group meetups" }
                            li { "(Central PA) New Tech meetups" }
                            li { "SCROUNGE - Students for Computer Recycling to Outfit Underrepresented Non-profit Groups in Education" }
                        }
                    }
                    ],
                    [
                    q{Hobbies} => sub {
                        ul {
                            li { "Traveling" }
                            li { "Tinkering with technology" }
                            li { "IRC" }
                        }
                    }
                    ]
                );

                for (@interests) {
                    my ($topic, $code) = @$_;
                    p {
                        b { $topic } br {};
                        $code->();
                    }
                }
            }
            ]
        );

        for (@sections) {
            my ($item, $code) = @$_;
            template $item => $code;
        }

        template section => sub {
            my $self = shift;
            my $section = shift;
            my $item = first { $_->[0] eq $section } @sections;

            div {
                attr {
                    class is "header"
                }
                big { uc $section }
            };
            $item->[1]->();
        };

        template top => sub {
            div { img { attr { src is "top.gif" } } }
        };

        template footer => sub {
            p { em { small { "Resume was last generated: " . localtime } } }
        };

        template wrap => sub {
            html {
                head {
                    link { attr { rel is 'stylesheet', href is 'resume.css' } }
                    title { 'Resume - jasonmay - York, PA' }
                    meta {
                        attr {
                            name is "description",
                            content is "This is the home of jasonmay, programmer of " .
                            "Perl, tinkerer of technology, networking/programming " .
                            "enthusiast.",
                        }
                    }
                    meta {
                        attr {
                            name is "keywords",
                            content is "jasonmay, linux, perl, git, github, web, html, css, jquery, postgresql, york, pa, pennsylvania",
                        }
                    }
                    meta {
                        attr {
                            name is "author",
                            content is "jasonmay",
                        }
                    }
                }
                body {
                    show 'top';
                    show('section', $_->[0]) for @sections;
                    show 'footer';
                }
            }
        };

        1;
