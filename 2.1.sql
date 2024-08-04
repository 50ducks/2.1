WITH dup_number AS (
	SELECT ctid
		, ROW_NUMBER() OVER(
			PARTITION BY client_rk
				, effective_from_date
		) AS rnk
	FROM dm.client
)
DELETE FROM dm.client
WHERE ctid IN (
	SELECT ctid 
	FROM dup_number 
	WHERE rnk > 1); 