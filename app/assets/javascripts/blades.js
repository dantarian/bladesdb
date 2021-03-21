// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function toggleGameDetails(id) {
	$("#gamedetailsrow" + id).toggle();
	$("#show_details_" + id).toggle();
	$("#hide_details_" + id).toggle();
}

function updateShowDetailsActions(elementId, showElementId, hideElementId) {
    if ($(elementId).is(":visible")) {
        $("#" + showElementId).hide();
        $("#" + hideElementId).show();
    } else {
        $("#" + showElementId).show();
        $("#" + hideElementId).hide();
    }
}

function toggleBriefs(id) {
	$("#briefs" + id).toggle();
	$("#show_briefs_" + id).toggle();
	$("#hide_briefs_" + id).toggle();
}

function toggleMessage(id) {
    $("#deletedmessage" + id).toggle();
    $("#show_message_" + id).toggle();
    $("#hide_message_" + id).toggle();
}

function toggleComments(comment_type, id) {
	$("#" + comment_type + "_comments_" + id).toggle();
	$("#show_" + comment_type + "_comments_" + id).toggle();
	$("#hide_" + comment_type + "_comments_" + id).toggle();
}

function makePrimaryForMerge(id) {
    $("table.source tr.primary").removeClass("primary");
    $("table.source tr#record" + id).addClass("primary");
    $("#primary").val(id);
    updateMergeSelections();
}

function makeSecondaryForMerge(id) {
    $("table.source tr.secondary").removeClass("secondary");
    $("table.source tr#record" + id).addClass("secondary");
    $("#secondary").val(id);
    updateMergeSelections();
}

function deselectForMerge(id) {
    if ($("#primary").val() == id) {
        $("#primary").val("");
    }
    if ($("#secondary").val() == id) {
        $("#secondary").val("");
    }
    $("table.source tr#record" + id).removeClass("primary").removeClass("secondary");
    updateMergeSelections();
}

function updateMergeSelections() {
    $("table.primary tbody tr, table.secondary tbody tr").remove();
    $("table.source tr.primary").clone().attr("id", "primary_record").appendTo("table.primary tbody");
    $("table.source tr.secondary").clone().attr("id", "secondary_record").appendTo("table.secondary tbody");
    $("input[type='submit']").attr("disabled", $("#primary").val() == "" || $("#secondary").val() == "");
}

function monster_point_cost() {
    var total = 0;
    var cp = $("#charRank").text() * 10;
    var cp_gained = parseInt($("#monster_point_spend_character_points_gained").val());

    for (var i = cp; i < cp + cp_gained; ++i) {
        total += Math.floor(i / 100) + 1;
    }
    return total;
}

function printpage() {
  window.print();
};

$(function () {
	if ($("table.source").size() > 0) {
	    updateMergeSelections();
	}
});

// Find all the tables on the page, and apply odd/even styling to them.
$(function () {
	// Now, for each table:
	$("table").not(".prestyled, #recaptcha_table").each(function () {
		// Make sure any empty cells contain a non-breaking space.
		$(this).find("td").each(function () {
			if ($(this).text().trim() == "") {
				$(this).html("&nbsp;");
			}
		});

		// Iterate over the rows.
		var odd = true;
		$(this).find("tr").each(function () {
			if ($(this).parents("thead").length > 0 || $(this).hasClass("title")) {
				odd = true;
			} else {
				// If the current row has class "hold", then revert to the previous odd/even state.
				if ($(this).hasClass("hold")) {
					odd = !odd;
				}
				if (odd) {
					$(this).addClass("odd");
				} else {
					$(this).addClass("even");
				}
				odd = !odd;
			}
		});
	});
});

$(function() {
	$('table.sortable').each( function() {
		var aoColumns = [];
		$(this).find('thead th').each( function () {
		    if ( $(this).hasClass( 'no_sort' ) ) {
		        aoColumns.push( { "bSortable": false } );
		    } else {
		        aoColumns.push( null );
		    }
		});
		var defaultSort = [];
		var defaultColumn = $(this).find('thead th.defaultColumn');
		if ( defaultColumn.size() > 0 ) {
			var defaultIndex = defaultColumn.index();
			var descending = defaultColumn.hasClass("descending");
			defaultSort = [[defaultIndex, descending ? "desc" : "asc"]];
		} else {
			defaultSort = [[0, "asc"]];
		}
		$(this).dataTable({
			"bPaginate": false,
	        "bLengthChange": false,
	        "bFilter": false,
	        "bInfo": false,
	        "bAutoWidth": false,
	        "aoColumns": aoColumns,
	        "aaSorting": defaultSort
		});
	});
});

$(function () {
	$("div.sidebarcategory h3 a").click(function (event) {
		$(this).closest("div.sidebarcategory").find(".sidebarsection").toggle();
		event.preventDefault();
	});
});

$(function () {
    $("#dialog").delegate("#monster_point_spend_character_points_gained", "click keyup change", function () {
        $("#mpCost").text(monster_point_cost());
    });
});

$(function () {
    $("#dialog").delegate("input.radiocontroller", "click keyup change", function () {
        var radioButtonGroupName = $(this).attr("name");
        $("input.radiocontroller[name='" + radioButtonGroupName + "']").each(function () {
            if ($(this).is(":checked")) {
                $(this).parent(".radiocontainer").find(".radiocontrolled").removeAttr("disabled");
            } else {
                $(this).parent(".radiocontainer").find(".radiocontrolled").attr("disabled", "disabled");
            }
        });
    });
});

$(function () {
    $("#dialog").delegate("input#game_attendance_only", "click change", function () {
        var attendanceOnly = $(this).is(":checked");
        if (attendanceOnly) {
            $("#dialog").find("input#game_lower_rank, input#game_upper_rank, select#game_campaign_ids, input#game_open, input#game_non_stats").attr("disabled", "disabled");
        } else {
            $("#dialog").find("input#game_lower_rank, input#game_upper_rank, select#game_campaign_ids, input#game_open, input#game_non_stats").removeAttr("disabled");
        }
    });
});

$(function () {
    $("#dialog").delegate("select#state", "click change", function () {
        $("#game_attendance_character_id").prop("disabled", $(this).find(":selected").text() != "Play");
    });
});

$(function () {

	var guildOptionElement = function(id, title, selected) {
		return $("<option></option>")
			.prop("id", id)
      .prop("value", id)
			.prop("selected", (selected ? "selected" : ""))
			.append(title);
	};

	var updateGuildBranches = function(guild_selector, guild_branch_selector) {
		var selectedGuild = $(guild_selector).find("option:selected").val();
		var guilds = $(guild_branch_selector).data("guildmap");

		$(guild_branch_selector).find("option").remove();

		if (guilds !== null && guilds !== undefined && selectedGuild !== null && selectedGuild !== undefined) {
			$(guild_branch_selector).append(
				$.map(guilds[selectedGuild], function (value, key) {
					return guildOptionElement(key, value, key == guilds["selected"]);
				})
			);
			$(guild_branch_selector).prop("disabled", $(guild_branch_selector).find("option").length == 0);
		}
	};

    var updateGuildBranchesIfAppropriate = function() {
    	var guilds = $("select#guild_selector");
    	var guild_branches = $("select#guild_branch_selector");

    	if (guilds.length > 0 && guild_branches.length > 0) {
    		updateGuildBranches(guilds, guild_branches);
    	}
    };

    $("#dialog").on("dialogopen", updateGuildBranchesIfAppropriate);
    $("#dialog").delegate("select#guild_selector", "change", updateGuildBranchesIfAppropriate);
});

$(function () {
	$("body").delegate("input:radio[name='radio_type']", "click change", function () {
        $("input:radio[name='radio_type']").each( function () {
	        	$(this).closest("div.options_container").find(".switch_enabled").prop("disabled", !$(this).prop("checked"));
	        }
       );
    });
});

$(function () {
	$("body").delegate("input:radio[name='radio_title']", "click change", function () {
        $("input:text[id='character_title']").prop("disabled", !$("input:radio[id='radio_title_custom']").prop("checked"));
    });
});

$(function() {
	$("body").on("click", "a.show_hide_next_row", function (event) {
		$(this).closest("tr").next().toggle();
		if ($(this).closest("table").is("#eventcalendar")) {
			var details_row = $(this).closest("tr").next();
			if (details_row.data("loaded") != "true") {
				details_row.data("loaded", "true");
			} else {
				return false;
			}
		}
		event.preventDefault();
	});
});


$(function () {
	$("body").delegate("a[data-primary]", "click", function (event) {
		event.preventDefault();
		var id = $(event.target).data("primary");
	    makePrimaryForMerge(id);
    });
});

$(function () {
	$("body").delegate("a[data-secondary]", "click", function (event) {
		event.preventDefault();
		var id = $(event.target).data("secondary");
	    makeSecondaryForMerge(id);
    });
});

$(function () {
	$("body").delegate("a[data-deselect]", "click", function (event) {
		event.preventDefault();
		var id = $(event.target).data("deselect");
	    deselectForMerge(id);
    });
});

$(function () {
	$("body").delegate("input.datepicker", "focus", function (event) {
    var min = $(event.target).data("mindate");
    var max = $(event.target).data("maxdate");
    var yearrange = $(event.target).data("yearrange");
    $(event.target).datepicker({dateFormat: "D d M yy", minDate: min, maxDate: max, yearRange: yearrange, changeYear: true, changeMonth: true});
		$(event.target).datepicker('show');
  });
});

$(function () {
	$("body").delegate("a.toggle_message", "click", function (event) {
		event.preventDefault();
		var id = $(event.target).data("message");
	    toggleMessage(id);
    });
});