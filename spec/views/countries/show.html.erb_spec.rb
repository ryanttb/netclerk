require 'spec_helper'

describe ( 'countries/show' ) {
  subject { rendered }

  context ( 'default view' ) {
    let ( :p ) { Page.find_by_title 'The White House' }
    let ( :c ) { Country.find_by_name 'Iran' }
    let ( :ss ) {
      Status.most_recent.where( country: c ).group_by { |s| s.value }
    }
    let ( :s ) {
      Status.most_recent.find_by( page: p, country: c )
    }

    before {
      assign( :country, c )
      assign( :statuses, ss )
    
      render
    }

    it { should have_css '.media .media-body' }

    it { should have_css '.media-body .media-heading', text: c.name }

    describe ( 'changed' ) {
      it { pending "should have_css 'h2', text: 'Changed since yesterday'" }
    }

    describe ( 'top urls' ) {
      it { should have_css 'h2', text: 'Top URLs' }

      it {
        should have_css '.list-group', count: Page.count
      }

      it ( 'should link to statuses' ) {
        should have_css %(.pages-status-warning a.list-group-item[href*="#{status_path s}"]), text: p.title, count: 1
      }

    }
  }
}
